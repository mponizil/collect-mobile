class MainViewController < ContainerViewController
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
    @myCollectionController.delegate = self
    @navigationController = UINavigationController.alloc.initWithRootViewController(@myCollectionController)
    addContentController(@navigationController)
  end

  def myCollectionController(myCollectionController, didLogOutUser: user)
    removeContentController(@myCollectionController)
  end

  def authController(authController, didLogInUser: user)
    removeContentController(@authController)
  end
end
