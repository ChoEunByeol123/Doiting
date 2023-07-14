import UIKit
import DropDown

class SignUp2ViewController: UIViewController {

    
    @IBOutlet weak var btnSexMale: UIButton!
    @IBOutlet weak var btnSexFemale: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!

    @IBOutlet weak var fieldName: UIStackView!
    @IBOutlet weak var fieldBirthDay: UIStackView!
    @IBOutlet weak var fieldTel: UIView!
    @IBOutlet weak var fieldPhoneNum: UIStackView!
    
    @IBOutlet weak var dropTelView: UIView!
    @IBOutlet weak var textTel: UITextField!
    @IBOutlet weak var iconTel: UIImageView!
    
    
    // MARK: - Tel DropDown Variable
    let dropdown = DropDown()
    let itemList = ["SKT", "KT", "LG U+", "SKT 알뜰폰", "KT 알뜰폰", "LG U+ 알뜰폰"  ]
    
    // MARK: - Color Variable
    // color 정리 필요
    let MainColor1 = UIColor(named: "MainColor1")
    let MainColor2 = UIColor(named: "MainColor2")
    let LightGrayColor = UIColor(named: "FontColorLightGray")
    let DisabledColor = UIColor(named: "DisabledColor")
    let MinLightgray = UIColor.systemGray5
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        initFunc()
    }
    
    
    // MARK: - viewDidLayoutSubviews()
    override func viewDidLayoutSubviews() {
        setBorder()
    }
    
    
    // MARK: - Set init Function
    func initUI(){
        setRadius()
        setDropDownCustomUI()
    }
    
    func setBorder(){
        fieldName.layer.addBorder([.bottom], color: MinLightgray, width: 1.0)
        fieldBirthDay.layer.addBorder([.bottom], color: MinLightgray, width: 1.0)
        fieldTel.layer.addBorder([.bottom], color: MinLightgray, width: 1.0)
        fieldPhoneNum.layer.addBorder([.bottom], color: MinLightgray, width: 1.0)
    }
    
    func setRadius(){
        btnSexMale.layer.cornerRadius = 10
        btnSexFemale.layer.cornerRadius = 10
        btnNext.layer.cornerRadius = 10
    }

    func setDropDownCustomUI(){
        DropDown.appearance().textColor = UIColor.black // 아이템 텍스트 색상
        DropDown.appearance().selectedTextColor = MainColor1!// 선택된 아이템 텍스트 색상
        DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
        DropDown.appearance().selectionBackgroundColor = MinLightgray // 선택한 아이템 배경 색상
        DropDown.appearance().setupCornerRadius(8)
        dropdown.dismissMode = .automatic // 팝업을 닫을 모드 설정
        
    }

    func initFunc(){
        setDropDownFunction()
    }
    
    func setDropDownFunction(){
        // dataSource로 itemList를 연결
        dropdown.dataSource = itemList
        
        // anchorView를 통해 UI와 연결
        dropdown.anchorView = self.dropTelView
        
        // View를 가리지 않고 View 아래에 Item 팝업이 붙도록 설정
        dropdown.bottomOffset = CGPoint(x: 0, y: dropTelView.bounds.height)
        
        // Item 선택 시 처리
        dropdown.selectionAction = { [weak self] (index, item) in
            // 선택한 Item을 textField에 넣어준다.
            self!.textTel.text = item
            self!.iconTel.image = UIImage(systemName: "chevron.down")
        }
        
        // 취소 시 처리
        dropdown.cancelAction = { [weak self] in
            // 빈 화면 터치 시 DropDown이 사라지고 아이콘을 원래대로 변경
            self!.iconTel.image = UIImage(systemName: "chevron.down")
        }
    }
    
    
    // MARK: - Tapped Function
    @IBAction func btnDropDownTelTapped(_ sender: Any) {
        // 아이템 팝업을 보여준다.
        dropdown.show()
        
        // 아이콘 이미지를 변경하여 DropDown이 펼쳐진 것을 표현
        self.iconTel.image = UIImage(systemName: "chevron.up")
    }
    
    
    
    // MARK: - Etc Function
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
    
}


// MARK: - 확장 : View Border Line
extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
