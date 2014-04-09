class MainViewController < ContainerViewController
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
end
