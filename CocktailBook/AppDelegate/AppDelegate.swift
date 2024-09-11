import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController: UINavigationController? = UIStoryboard.screenController(storyboardId: AppConstants.StoryboardId.navigationController)
        
        self.window?.rootViewController = navigationController
        
        self.window?.makeKeyAndVisible()
        return true
    }
}
