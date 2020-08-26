import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let name = String(describing: "SyncViewController")
        let vc = sb.instantiateViewController(withIdentifier: name) as! SyncViewController

        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()

        return true
    }

}
