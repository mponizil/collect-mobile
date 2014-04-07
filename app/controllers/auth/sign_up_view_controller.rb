class SignUpViewController < PFSignUpViewController
  def viewDidLoad
    super
    self.signUpView.usernameField.placeholder = 'Email'
  end
end
