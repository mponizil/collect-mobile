class ContainerController < UIViewController
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
      addContentController(@authController)
    end
  end

  def showMyCollection
    @myCollectionController = MyCollectionController.alloc.init
    @navigationController = UINavigationController.alloc.initWithRootViewController(@myCollectionController)
    addContentController(@navigationController)
  end

  def authController(authController, didLogInUser: user)
    removeContentController(@authController)
  end

  def addContentController(contentController)
    addChildViewController(contentController)
    @currentClientView = contentController.view
    contentController.view.frame = view.frame
    view.addSubview(@currentClientView)
    contentController.didMoveToParentViewController(self)
  end

  def removeContentController(contentController)
    contentController.willMoveToParentViewController(nil)
    contentController.view.removeFromSuperview
    contentController.removeFromParentViewController
  end
end
