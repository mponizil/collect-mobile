class ViewController < UIViewController
  def viewDidLoad
    super
    puts 'viewDidLoad'
  end

  def viewDidAppear(animated)
    if PFUser.currentUser
      showFeed
    else
      showLogin
    end
  end

  def showFeed
    puts 'show feed now'
  end

  def showLogin
    @login = LogInViewController.alloc.init
    @login.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsSignUpButton
    @login.delegate = self

    @login.signUpController = SignUpViewController.alloc.init
    @login.signUpController.fields = PFSignUpFieldsUsernameAndPassword | PFSignUpFieldsSignUpButton | PFSignUpFieldsDismissButton
    @login.signUpController.delegate = self

    self.presentViewController(@login, animated: true, completion: nil)
  end

  def logInViewController(logInViewController, didLogInUser: user)
    self.dismissViewControllerAnimated(true, completion: nil)
  end
end
