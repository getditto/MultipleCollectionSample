import DittoSwift

struct DittoBasicInfo {

    static let accessLicense = "<Input Your Access License>"

    private static let appName = "multiple_collections_example"

    static let identity = DittoIdentity.development(appName: DittoBasicInfo.appName)

}
