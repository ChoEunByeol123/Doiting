import UIKit

class SignUp1ViewController: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var checkAll: UIImageView!
    @IBOutlet weak var check1: UIImageView!
    @IBOutlet weak var check2: UIImageView!
    @IBOutlet weak var check3: UIImageView!
    @IBOutlet weak var check4: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRadius()
        setImageTapped()
    }

    func setImageTapped(){
        let tapCheckAll = UITapGestureRecognizer(target: self, action: #selector(self.checkAllTapped))
        let tabCheck1 = UITapGestureRecognizer(target: self, action: #selector(self.check1Tapped))
        let tabCheck2 = UITapGestureRecognizer(target: self, action: #selector(self.check2Tapped))
        let tabCheck3 = UITapGestureRecognizer(target: self, action: #selector(self.check3Tapped))
        let tabCheck4 = UITapGestureRecognizer(target: self, action: #selector(self.check4Tapped))
        
        checkAll.addGestureRecognizer(tapCheckAll)
        check1.addGestureRecognizer(tabCheck1)
        check2.addGestureRecognizer(tabCheck2)
        check3.addGestureRecognizer(tabCheck3)
        check4.addGestureRecognizer(tabCheck4)
        
        checkAll.isUserInteractionEnabled = true
        check1.isUserInteractionEnabled = true
        check2.isUserInteractionEnabled = true
        check3.isUserInteractionEnabled = true
        check4.isUserInteractionEnabled = true
    }
    
    func setRadius(){
        btnNext.layer.cornerRadius = 10
    }
    
    
    @objc func checkAllTapped(sender: UITapGestureRecognizer) {
            if sender.state == .ended {
                checkAll.tintColor = UIColor(named: "MainColor2")
            }
    }
    @objc func check1Tapped(sender: UITapGestureRecognizer) {
            if sender.state == .ended {
                check1.tintColor = UIColor(named: "MainColor2")
            }
    }
    @objc func check2Tapped(sender: UITapGestureRecognizer) {
            if sender.state == .ended {
                check2.tintColor = UIColor(named: "MainColor2")
            }
    }
    @objc func check3Tapped(sender: UITapGestureRecognizer) {
            if sender.state == .ended {
                check3.tintColor = UIColor(named: "MainColor2")
            }
    }
    @objc func check4Tapped(sender: UITapGestureRecognizer) {
            if sender.state == .ended {
                check4.tintColor = UIColor(named: "MainColor2")
            }
    }
    
    
}
