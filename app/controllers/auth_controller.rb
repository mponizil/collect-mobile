class AuthController < UIViewController
  attr_accessor :delegate

  def viewDidAppear(animated)
    @loginController = LogInViewController.alloc.init
    @loginController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsSignUpButton
    @loginController.delegate = self

    @loginController.signUpController = SignUpViewController.alloc.init
    @loginController.signUpController.fields = PFSignUpFieldsUsernameAndPassword | PFSignUpFieldsSignUpButton | PFSignUpFieldsDismissButton
    @loginController.signUpController.delegate = self

    presentViewController(@loginController, animated: true, completion: nil)
  end

  def logInViewController(logInViewController, didLogInUser: user)
    dismissViewControllerAnimated(true, completion: nil)
    delegate.authController(self, didLogInUser: user)
  end
end
