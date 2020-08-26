import DittoKitSwift

protocol DittoHandlerType: AnyObject {
    init(didChangeCounts: @escaping ((DittoHandler.CollectionType, Int) -> Void))
    var didChangeCounts: ((DittoHandler.CollectionType, Int) -> Void) { get }
    func countUp(type: DittoHandler.CollectionType)
    func observe(type: DittoHandler.CollectionType)
    func stop(type: DittoHandler.CollectionType)
    func reset()
}

final class DittoHandler: DittoHandlerType {

    enum CollectionType {
        case A, B
    }

    private var ditto: DittoKit = {
        let ditto = DittoKit(identity: DittoBasicInfo.identity)
        ditto.setAccessLicense(DittoBasicInfo.accessLicense)
        ditto.start()
        return ditto
    }()

    private let countDocID = "countDocID"
    private let countDocKey = "count"

    private let collectionA: DittoCollection
    private let collectionB: DittoCollection

    private var liveQueryA: DittoLiveQuery? = nil
    private var liveQueryB: DittoLiveQuery? = nil

    init(didChangeCounts: @escaping ((CollectionType, Int) -> Void)) {
        self.didChangeCounts = didChangeCounts
        self.collectionA = ditto.store.collection("A")
        self.collectionB = ditto.store.collection("B")
        setupCollections()
    }

    var didChangeCounts: ((CollectionType, Int) -> Void)

    func countUp(type: CollectionType) {
        collection(type: type).findByID(countDocID).update { [weak self] doc in
            guard let self = self else { return }
            let path = doc?[self.countDocKey]
            path?.increment(amount: 1)
            let count = path?.int ?? 0
            self.didChangeCounts(type, count)
        }
    }

    func observe(type: CollectionType) {
        if type == .A {
            liveQueryA = collection(type: type).findAll().observe { [weak self] newDocs, event in
                guard let self = self else { return }
                self.log(type: type, newDocs: newDocs, event: event)
                self.notifyChange(type: type, docs: newDocs)
            }
        } else if type == .B {
            liveQueryB = collection(type: type).findAll().observe { [weak self] newDocs, event in
                guard let self = self else { return }
                self.log(type: type, newDocs: newDocs, event: event)
                self.notifyChange(type: type, docs: newDocs)
            }
        }
    }

    func stop(type: CollectionType) {
        var lq = liveQuery(type: type)
        print("\(#function) - \(lq.debugDescription)")

        lq?.stop()
        lq = nil
    }

    func reset() {
        [collectionA, collectionB].forEach { collection in
            let target = collection.findByID(countDocID)
            let existing = target.exec()
            let count = existing?[countDocKey].double ?? 0
            target.update { doc in
                doc?[self.countDocKey].increment(amount: -count)
            }
        }
    }

    // MARK: Privates

    private func setupCollections() {
        [collectionA, collectionB].forEach { collection in
            if collection.findByID(countDocID).exec() == nil {
                _ = try? collection.insert([countDocKey: 0], withID: countDocID, isDefault: true)

                collection.findByID(countDocID).update { [weak self] doc in
                    guard let self = self else { return }
                    doc?[self.countDocKey].replaceWithCounter(isDefault: true)
                }
            }
        }

        observe(type: .A)
        observe(type: .B)
    }

    private func notifyChange(type: CollectionType, docs: [DittoDocument]) {
        let count = docs.first?[countDocKey].int ?? 0
        self.didChangeCounts(type, count)
    }

    private func log(type: CollectionType, newDocs: [DittoDocument], event: DittoLiveQueryEvent) {
        print("\(type) \(event.description) - newDocs: \(newDocs)")

        switch event {
        case .initial:
            break
        case .update(let updates):
            let oldDocs = updates.oldDocuments
            print("\(type) - oldDocs: \(oldDocs)")
        @unknown default:
            break
        }
    }

    private func collection(type: CollectionType) -> DittoCollection {
        switch type {
        case .A:
            return collectionA
        case .B:
            return collectionB
        }
    }

    private func liveQuery(type: CollectionType) -> DittoLiveQuery? {
        switch type {
        case .A:
            return liveQueryA
        case .B:
            return liveQueryB
        }
    }
}