import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController: UINavigationController?
    var accountViewController: AccountViewController?
    var productViewController: ProductViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Create a window and set it as the app's main window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // login - initial viewcontroller, set as root
        let loginViewController = LoginViewController()
        navigationController = UINavigationController(rootViewController: loginViewController)
        window?.rootViewController = navigationController
        
        // Make the window visible
        window?.makeKeyAndVisible()
        
        
        
        return true
    }
    
}
