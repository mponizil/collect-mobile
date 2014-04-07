class ViewController < UIViewController
  def viewDidLoad
    super
    view.backgroundColor = UIColor.whiteColor
  end

  def viewDidAppear(animated)
    if PFUser.currentUser
      showMyCollection
    else
      @authController = AuthController.alloc.init
      @authController.delegate = self
      displayContentController(@authController)
    end
  end

  def showMyCollection
    @myCollectionController = MyCollectionController.alloc.init
    @navigationController = UINavigationController.alloc.initWithRootViewController(@myCollectionController)
    displayContentController(@navigationController)
  end

  def authController(authController, didLogInUser: user)
    hideContentController(@authController)
  end

  def displayContentController(content)
    addChildViewController(content)
    @currentClientView = content.view
    content.view.frame = view.frame
    view.addSubview(@currentClientView)
    content.didMoveToParentViewController(self)
  end

  def hideContentController(content)
    content.willMoveToParentViewController(nil)
    content.view.removeFromSuperview
    content.removeFromParentViewController
  end
end
