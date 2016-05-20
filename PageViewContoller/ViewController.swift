import UIKit

class ViewController: UIViewController {
    
    var pageViewController:UIPageViewController!
    
    let animals:[Animal] = [
        Animal(name: "Dog", image: UIImage(named: "dog")!, sound: "Woof"),
        Animal(name: "Cat", image: UIImage(named: "cat")!, sound: "Meow"),
        Animal(name: "Bird", image: UIImage(named: "bird")!, sound: "Tweet"),
        Animal(name: "Cow", image: UIImage(named: "cow")!, sound: "Moo"),
        Animal(name: "Seal", image: UIImage(named: "seal")!, sound: "Ow Ow Ow"),
        Animal(name:  "What does the Fox Say?", image: UIImage(named: "fox")!, sound: "Ring-ding-ding-ding-dingeringeding!\nGering-ding-ding-ding-dingeringeding!\nGering-ding-ding-ding-dingeringeding!")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
    }

    var animalActiveFlag = false
    @IBAction func showAnimals(sender: AnyObject) {
        if !animalActiveFlag {
            showPageViewControl()
            animalActiveFlag = true
        } else {
            closeTutorial()
            animalActiveFlag = false
        }
    }
    
    func closeTutorial() {
        self.pageViewController.view.removeFromSuperview()
        self.pageViewController.removeFromParentViewController()
    }
    
    func showPageViewControl() {
        let startVC = self.viewcontrollerAtIndex(0) as ContentViewController
        let viewControllers = NSArray(object:  startVC)
        
        self.pageViewController.setViewControllers((viewControllers as! [UIViewController]), direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    func viewcontrollerAtIndex(index:Int) -> ContentViewController {
        
        if self.animals.count == 0 || index >= self.animals.count {
            return ContentViewController()
        }
        
        let vc:ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        vc.imageFile = self.animals[index].image
        vc.titleText = self.animals[index].name
        vc.descriptionText = self.animals[index].sound
        
        vc.pageIndex = index
        
        print("viewcontrollerAtIndex - \(index)")
        print(self.animals.count)
        
        return vc
    }
}

extension ViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        
        index -= 1
        
        print("index: \(index)")
        
        return self.viewcontrollerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if index == NSNotFound {
            
            return nil
        }
        
        index += 1
        
        if index == self.animals.count {
            return nil
        }
        
        print("index: \(index)")
        
        return self.viewcontrollerAtIndex(index)
        
    }
    
    //MARK: - NOT REQUIRED - Add dots at the bottom of PageViewController

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.animals.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

