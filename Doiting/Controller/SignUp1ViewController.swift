import UIKit

class SignUp1ViewController: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var checkAll: UIImageView!
    @IBOutlet weak var check1: UIImageView!
    @IBOutlet weak var check2: UIImageView!
    @IBOutlet weak var check3: UIImageView!
    @IBOutlet weak var check4: UIImageView!
    
    @IBOutlet weak var seeMore1: UILabel!
    
    // MARK: - 뷰디드로드
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setRadius()
        setCheckBoxTapped()
        setSeeMore()
    }
    
    
    // MARK: - 기본설정

    func setNavigation(){
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            backBarButtonItem.tintColor = UIColor(named: "LightGrayColor")
            self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func setRadius(){
        btnNext.layer.cornerRadius = 10
    }

    func setCheckBoxTapped(){
        let tabCheckAll = UITapGestureRecognizer(target: self, action: #selector(self.checkAllTapped))
        let tabCheck1 = UITapGestureRecognizer(target: self, action: #selector(self.check1Tapped))
        let tabCheck2 = UITapGestureRecognizer(target: self, action: #selector(self.check2Tapped))
        let tabCheck3 = UITapGestureRecognizer(target: self, action: #selector(self.check3Tapped))
        let tabCheck4 = UITapGestureRecognizer(target: self, action: #selector(self.check4Tapped))
        
        checkAll.addGestureRecognizer(tabCheckAll)
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
    
    func setSeeMore(){
        let tabSeeMore = UITapGestureRecognizer(target: self, action: #selector(self.seeMore1Tapped))
        seeMore1.addGestureRecognizer(tabSeeMore)
        seeMore1.isUserInteractionEnabled = true
    }
    
    
    // MARK: - [체크박스] 사용자 정의 함수 (@objc)
    let CheckedColor = UIColor(named: "MainColor2")
    let UnCheckedColor = UIColor(named: "LightGrayColor")
    let DisabledColor = UIColor(named: "DisabledColor")
    let MainColor1 = UIColor(named: "MainColor1")
    
    func ChangebtnNextActiveYN(){
        if checkAll.tintColor == CheckedColor{
            btnNext.backgroundColor = MainColor1
            btnNext.isEnabled = true
        }
        else{
            btnNext.backgroundColor = DisabledColor
            btnNext.isEnabled = false
        }
    }
    
    func CheckAllActiveYN(){
        if check1.tintColor == CheckedColor && check2.tintColor == CheckedColor && check3.tintColor == CheckedColor{
            checkAll.tintColor = CheckedColor
        }
        else{
            checkAll.tintColor = UnCheckedColor
        }
    }
    
    @objc func checkAllTapped(sender: UITapGestureRecognizer) {
        if checkAll.tintColor == CheckedColor{
            checkAll.tintColor = UnCheckedColor
            check1.tintColor = UnCheckedColor
            check2.tintColor = UnCheckedColor
            check3.tintColor = UnCheckedColor
            check4.tintColor = UnCheckedColor
        }
        else{
            checkAll.tintColor = CheckedColor
            check1.tintColor = CheckedColor
            check2.tintColor = CheckedColor
            check3.tintColor = CheckedColor
            check4.tintColor = CheckedColor
        }
        
        ChangebtnNextActiveYN()
    }
    
    @objc func check1Tapped(sender: UITapGestureRecognizer) {
        if check1.tintColor == CheckedColor{
            check1.tintColor = UnCheckedColor
        }
        else{
            check1.tintColor = CheckedColor
        }
        CheckAllActiveYN()
        ChangebtnNextActiveYN()
    }
    
    @objc func check2Tapped(sender: UITapGestureRecognizer) {
        if check2.tintColor == CheckedColor{
            check2.tintColor = UnCheckedColor
        }
        else{
            check2.tintColor = CheckedColor
        }
        CheckAllActiveYN()
        ChangebtnNextActiveYN()
    }
    
    @objc func check3Tapped(sender: UITapGestureRecognizer) {
        if check3.tintColor == CheckedColor{
            check3.tintColor = UnCheckedColor
        }
        else{
            check3.tintColor = CheckedColor
        }
        CheckAllActiveYN()
        ChangebtnNextActiveYN()
    }
    
    @objc func check4Tapped(sender: UITapGestureRecognizer) {
        if check4.tintColor == CheckedColor{
            check4.tintColor = UnCheckedColor
        }
        else{
            check4.tintColor = CheckedColor
        }
        CheckAllActiveYN()
        ChangebtnNextActiveYN()
    }
    
    
    // MARK: - [더보기] 사용자 정의 함수 (@objc)

    @objc func seeMore1Tapped(){
        
    }
    
    
    // MARK: - 값 저장
    // 어떤 약관들을 동의했는지 DB에 값 저장 필요

    
    
}
