import DittoKitSwift

struct DittoBasicInfo {
    static let accessLicense = "o2d1c2VyX2lka0FOQSBTeXN0ZW1zZmV4cGlyeXQyMDIxLTAyLTI4VDAwOjAwOjAwWmlzaWduYXR1cmV4WHdLLzVMekdoY05IVThneExpMURwTmF5NFpueEx6bDFBYml5K3l0SmxPTFlrNTZYYTVNYm1sTDBHZFl6ZURuQ1JkQWZpVnlaaXFZcHI4OEUrdEJCYXpRPT0"

    private static let appName = "multiple_collections_example"

    static let identity = DittoIdentity.development(appName: DittoBasicInfo.appName)

    enum Collection {
        case collectionA
        case collectionB

        var name: String {
            return String(describing: self)
        }
    }
}
