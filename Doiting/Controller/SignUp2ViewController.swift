import UIKit

class SignUp2ViewController: UIViewController {

    
    @IBOutlet weak var btnSexMale: UIButton!
    @IBOutlet weak var btnSexFemale: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setRadius()
    }
    
    
    func setRadius(){
        btnSexMale.layer.cornerRadius = 10
        btnSexFemale.layer.cornerRadius = 10
        btnNext.layer.cornerRadius = 10
    }

    
    
    
    
}
