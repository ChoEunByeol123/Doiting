import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgDesc: UILabel!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFont()
        setRadius()
        setNavigation()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setNavigation(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            backBarButtonItem.tintColor = UIColor(named: "LightGrayColor")
            self.navigationItem.backBarButtonItem = backBarButtonItem
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

