class LogInViewController < PFLogInViewController
  def viewDidLoad
    super
    self.logInView.usernameField.placeholder = 'Email'
  end
end
