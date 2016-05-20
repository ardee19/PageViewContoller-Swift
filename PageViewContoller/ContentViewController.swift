import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var pageIndex:Int!
    var titleText:String!
    var imageFile:UIImage!
    var descriptionText:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = self.imageFile
        self.titleLable.text = self.titleText
        self.descriptionLabel.text = self.descriptionText
    }
}
