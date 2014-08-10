class MyCollectionController < UITableViewController
  attr_accessor :delegate

  def viewDidLoad
    super

    @items = []

    @refreshControl = UIRefreshControl.alloc.init
    @refreshControl.attributedTitle = NSAttributedString.alloc.initWithString("Pull to refresh")
    @refreshControl.addTarget(self, action: 'refreshView:', forControlEvents: UIControlEventValueChanged)
    self.refreshControl = @refreshControl

    @dataTable = UITableView.alloc.initWithFrame(CGRectMake(0, 0, view.frame.size.width,
        view.frame.size.height), style: UITableViewStylePlain)
    @dataTable.delegate = self
    @dataTable.dataSource = self
    @dataTable.backgroundView = nil
    view.addSubview(@dataTable)

    logout = UIBarButtonItem.alloc.initWithTitle('Logout', style: UIBarButtonItemStylePlain, target: self, action: 'logout')
    navigationItem.rightBarButtonItem = logout
  end

  def viewDidAppear(animated)
    fetchItems
  end

  def logout
    user = PFUser.currentUser
    PFUser.logOut
    delegate.myCollectionController(self, didLogOutUser: user)
  end

  def fetchItems
    query = PFQuery.queryWithClassName('Item')
    query.whereKey('collector', equalTo: PFUser.currentUser)
    query.orderByDescending('createdAt')
    query.findObjectsInBackgroundWithBlock(lambda do |items, error|
      @items = items
      @dataTable.reloadData
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

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    item = @items[indexPath.row]
    viewItemController = ViewItemController.alloc.initWithItem(item)
    navigationController.pushViewController(viewItemController, animated: true)
  end

  def refreshView(refresh)
    refresh.attributedTitle = NSAttributedString.alloc.initWithString("Refreshing data...")
    @refreshControl.attributedTitle = NSAttributedString.alloc.initWithString(sprintf("Last updated at %s", Time.now.strftime("%l:%M %p")))
    @refreshControl.endRefreshing
    fetchItems
  end
end
