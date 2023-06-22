import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgDesc: UILabel!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFont()
        setRadius()
    }

    func setFont(){
        let fontR16 = UIFont(name: "NanumSquareOTFR", size: 16)
        let fontB18 = UIFont(name: "NanumSquareOTFB", size: 18)
        
        imgDesc.font = fontR16
        btnSignIn.titleLabel?.font = fontB18
        btnSignUp.titleLabel?.font = fontB18

        // [ font 원래 이름 찾기 ]
//        for family in UIFont.familyNames {
//          print(family)
//
//          for sub in UIFont.fontNames(forFamilyName: family) {
//            print("====> \(sub)")
//          }
//        }
    }
    
    func setRadius(){
        btnSignIn.layer.cornerRadius = 10
        btnSignUp.layer.cornerRadius = 10
    }
    
}

