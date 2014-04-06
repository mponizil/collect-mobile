class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    Parse.setApplicationId(PARSE_APPLICATION_ID, clientKey: PARSE_CLIENT_KEY)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @viewController = ViewController.alloc.init
    @window.rootViewController = @viewController
    @window.makeKeyAndVisible

    true
  end
end
