import Foundation
import UIKit

struct Animal {
    var name:String?
    var image:UIImage?
    var sound:String?
    
    init(name:String, image:UIImage, sound:String){
        self.name = name
        self.image = image
        self.sound = sound
    }
}
