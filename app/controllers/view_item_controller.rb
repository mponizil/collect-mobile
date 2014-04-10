class ViewItemController < UIViewController
  attr_accessor :item

  NAVIGATION_BAR_HEIGHT = 64

  def initWithItem(item)
    @item = item
    init
  end

  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor

    imageURL = NSURL.URLWithString(@item['image'])
    imageData = NSData.dataWithContentsOfURL(imageURL)
    image = UIImage.alloc.initWithData(imageData)
    @imageView = UIImageView.alloc.initWithImage(image)
    @imageView.contentMode = UIViewContentModeScaleAspectFit
    @imageView.frame = [[0, NAVIGATION_BAR_HEIGHT + 20], [view.frame.size.width, 200]]
    view.addSubview(@imageView)

    titleY = NAVIGATION_BAR_HEIGHT + @imageView.frame.size.height
    @titleView = UILabel.alloc.initWithFrame [[0, titleY], [view.frame.size.width, 100]]
    @titleView.text = @item['title']
    @titleView.numberOfLines = 0
    @titleView.textAlignment = NSTextAlignmentCenter
    view.addSubview(@titleView)
  end

  def viewDidAppear(animated)
    super
  end
end
