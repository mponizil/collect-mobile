class ViewController < UIViewController
  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor
  end

  def viewDidAppear(animated)
    if PFUser.currentUser
      showFeed
    else
      showLogin
    end
  end

  def showFeed
    query = PFQuery.queryWithClassName('Item')
    query.whereKey('collector', equalTo: PFUser.currentUser)
    query.findObjectsInBackgroundWithBlock(lambda do |items, error|

      @items = items

      @dataTable = UITableView.alloc.initWithFrame(CGRectMake(0, 40, view.frame.size.width,
        view.frame.size.height - 40), style: UITableViewStylePlain)
      @dataTable.delegate = self
      @dataTable.dataSource = self
      @dataTable.backgroundView = nil
      view.addSubview(@dataTable)

    end)
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @items.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= 'cell'

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier: @reuseIdentifier)
    end

    item = @items[indexPath.row]
    imageURL = NSURL.URLWithString(item['image'])
    imageData = NSData.dataWithContentsOfURL(imageURL)
    cell.imageView.setImage(UIImage.alloc.initWithData(imageData))
    cell.textLabel.text = item['title']
    cell.detailTextLabel.text = item['url']

    cell
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
