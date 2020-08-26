import UIKit

final class SyncViewController: UIViewController {

    private let dittoHandler: DittoHandlerType

    init?(coder: NSCoder, dittoHandler: DittoHandlerType) {
        self.dittoHandler = dittoHandler
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

