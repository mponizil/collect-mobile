class ContainerViewController < UIViewController
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
