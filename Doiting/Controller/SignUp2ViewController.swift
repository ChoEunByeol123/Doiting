import UIKit
import DropDown
import SnapKit
import RxSwift
import RxCocoa
import RxKeyboard

// MARK: - Protocol
protocol KeyboardEvent where Self: UIViewController{
    var transformView: UIView { get }
    func setupKeyboardEvent()
}

// MARK: - ViewController

class SignUp2ViewController: UIViewController, KeyboardEvent {

    // MARK: - @IBOutlet
    // 이름
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textCountName: UILabel!
    
    // 성별
    @IBOutlet weak var btnSexMale: UIButton!
    @IBOutlet weak var btnSexFemale: UIButton!
    
    // 생년월일
    @IBOutlet weak var textFieldBirth: UITextField!
    
    // 통신사
    @IBOutlet weak var dropTelView: UIView!
    @IBOutlet weak var textTel: UITextField!
    @IBOutlet weak var iconTel: UIImageView!
    
    // 휴대폰번호
    @IBOutlet weak var textFieldPhoneNo: UITextField!
    
    // 다음
    @IBOutlet weak var btnNext: UIButton!

    // border field
    @IBOutlet weak var fieldName: UIStackView!
    @IBOutlet weak var fieldBirthDay: UIStackView!
    @IBOutlet weak var fieldTel: UIView!
    @IBOutlet weak var fieldPhoneNum: UIStackView!
    
    
    // MARK: - 통신사 DropDown Variable
    let dropdown = DropDown()
    let itemList = ["SKT", "KT", "LG U+", "SKT 알뜰폰", "KT 알뜰폰", "LG U+ 알뜰폰"  ]
    
    // MARK: - Color Variable
    let MainColor1 = UIColor(named: "MainColor1")
    let MainColor2 = UIColor(named: "MainColor2")
    let LightGrayColor1 = UIColor(named: "LightGrayColor")
    let LightGrayColor2 = UIColor.systemGray5
    let DisabledColor = UIColor(named: "DisabledColor")
    
    // MARK: KetBoardEvent Protocol Variable
    var transformView: UIView { return self.view }
    
    // MARK: NextBtn Active Variable
    var inputFinish: [Bool] = [false, false, false, false, false]
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        initFunc()
        setDelegate()
        setupKeyboardEvent() // keyBoardEvent의 setupKeyboardEvent
        self.hideKeyboardWhenTappedAround() // 다른 곳 터치했을 때 키보드 내리는 기능
        changeStatusBarBgColor(bgColor: UIColor.white) // StatusBar BackgroundColor 설정
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeKeyboardObserver() // KeyBoardEvent의 removeKeyboardObserver
    }
    
    // MARK: - viewDidLayoutSubviews()
    override func viewDidLayoutSubviews() {
        setBorder()
    }
    
        
    // MARK: - Set initUI
    func initUI(){
        setFont()
        setRadius()
        setDropDownCustomUI()
    }
     
    func setFont(){
        // ⭐️ TextField Font가 적용이 안되서 코드로 적용시켜주기
        let fontR16 = UIFont(name: "NanumSquareOTFR", size: 16)
        textFieldName.font = fontR16
        textFieldBirth.font = fontR16
        textTel.font = fontR16
        textFieldPhoneNo.font = fontR16
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
        DropDown.appearance().selectionBackgroundColor = LightGrayColor2 // 선택한 아이템 배경 색상
        DropDown.appearance().setupCornerRadius(8)
        dropdown.dismissMode = .automatic // 팝업을 닫을 모드 설정
    }
    
    func setBorder(){
        fieldName.layer.addBorder([.bottom], color: LightGrayColor2, width: 1.0)
        fieldBirthDay.layer.addBorder([.bottom], color: LightGrayColor2, width: 1.0)
        fieldTel.layer.addBorder([.bottom], color: LightGrayColor2, width: 1.0)
        fieldPhoneNum.layer.addBorder([.bottom], color: LightGrayColor2, width: 1.0)
    }
    

    // MARK: Set initFunc
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
            
            if self!.textTel.text == "" { self!.inputFinish[3] = false }
            else { self!.inputFinish[3] = true }
            
            self!.ChangebtnNextActiveYN()
        }
        
        // 취소 시 처리
        dropdown.cancelAction = { [weak self] in
            // 빈 화면 터치 시 DropDown이 사라지고 아이콘을 원래대로 변경
            self!.iconTel.image = UIImage(systemName: "chevron.down")
            
            if self!.textTel.text == "" { self!.inputFinish[3] = false }
            else { self!.inputFinish[3] = true }

            self!.ChangebtnNextActiveYN()
        }

    }
    
    func setDelegate(){
        textFieldName.delegate = self
        textFieldName.addTarget(self, action: #selector(FieldDidChange), for: .editingChanged)
        textFieldBirth.delegate = self
        textFieldBirth.addDoneButtonOnKeyboard()
        textFieldBirth.addTarget(self, action: #selector(FieldDidChange), for: .editingChanged)
        textFieldPhoneNo.delegate = self
        textFieldPhoneNo.addDoneButtonOnKeyboard()
        textFieldPhoneNo.addTarget(self, action: #selector(FieldDidChange), for: .editingChanged)
    }
    
    // MARK: - Tapped Function

    @IBAction func btnSexMaleTapped(_ sender: UIButton) {
        btnSexMale.backgroundColor = MainColor1
        btnSexFemale.backgroundColor = LightGrayColor1
    }
    
    @IBAction func btnSexFemaleTapped(_ sender: UIButton) {
        btnSexMale.backgroundColor = LightGrayColor1
        btnSexFemale.backgroundColor = MainColor1
    }
    
    @IBAction func btnDropDownTelTapped(_ sender: Any) {
        // 아이템 팝업을 보여준다.
        dropdown.show()
        
        // 아이콘 이미지를 변경하여 DropDown이 펼쳐진 것을 표현
        self.iconTel.image = UIImage(systemName: "chevron.up")
    }
    

    // MARK: - Etc Function
    func hideKeyboardWhenTappedAround(){
        // UITapGestureRecognizer 타입의 tap 변수 설정을 해준다.
        // tap이 되었을 때 dismisskeyboard가 호출될 수 있게 selector를 설정해준다.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        // cancelsTouchesInView는 뷰를 터치했을 때 정보들을 전달하게 되는데, 그 터치 정보를 중간에 커트하고 정보를 view에 보낼지 말지를 Bool 타입으로 설정하는 것.
        // 터치정보를 view에 중간에 끊김 없이 보내야 하니까 false로 설정
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    @objc func FieldDidChange(_ textField: UITextField){
        
        let textCount = textField.text?.count
        var switchCount = -1
        
        switch textField{
        case textFieldName :
            switchCount = 0
            break;
        case textFieldBirth:
            switchCount = 2
            break;
        case textFieldPhoneNo:
            switchCount = 4
            break;
        default:
            return;
        }
        
        // 키보드 업데이트 시 원하는 기능 (실시간 반응)
        if textField == textFieldName{ textCountName.text = "\(textCount ?? 0)/10" }
        
        if textField == textFieldName && textCount != 0 { inputFinish[switchCount] = true }
        else if textField == textFieldBirth && textCount == 8{ inputFinish[switchCount] = true }
        else if textField == textFieldPhoneNo && (textCount == 10 || textCount == 11) { inputFinish[switchCount] = true }
        else { inputFinish[switchCount] = false }
        
        ChangebtnNextActiveYN()
    }
    
    
    func ChangebtnNextActiveYN(){
        if inputFinish[0] == true && inputFinish[2] == true && inputFinish[3] == true && inputFinish[4] == true{
            btnNext.backgroundColor = MainColor1
            btnNext.isEnabled = true
        }
        else{
            btnNext.backgroundColor = DisabledColor
            btnNext.isEnabled = false
        }
    }
    
    
}

// MARK: - 확장 : Responder

// 현재 응답받는 UI를 알아내기 위해 사용 (어떤 textField or textView인지)
extension UIResponder{
    private struct Static{
        static weak var responder: UIResponder?
    }
    
    static var currentResponder: UIResponder?{
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc private func _trap(){
        Static.responder = self
    }
}


// MARK: - KeyboardEvent

extension KeyboardEvent where Self: UIViewController{
    func setupKeyboardEvent(){
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main) { [weak self] notification in
            self?.keyboardWillAppear(notification)
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main) { [weak self] notification in
            self?.keyboardWillDisappear(notification)
        }
    }
    
    func removeKeyboardObserver(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func keyboardWillAppear(_ sender: Notification){
        // keyboardFrame : 현재 동작하고 있는 이벤트에서 키보드의 frame을 받아온다
        // currentTextField : 현재 응답을 받고 있는 UITextField를 알아낸다
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentResponder as? UITextField else { return }
        
        // Y축으로 키보드의 상단 위치
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        
        // 현재 선택한 텍스트필드의 Frame값
        let convertedTextFieldFrame = transformView.convert(currentTextField.frame, from: currentTextField.superview)
        
        // Y축으로 현재 텍스트 필드의 하단 위치
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        // Y축으로 텍스트필드 하단 위치가 키보드 상단 위치보다 클 때 (즉, 텍스트필드가 키보드에 가려질 때)
        if textFieldBottomY > keyboardTopY{
            let textFieldTopY = convertedTextFieldFrame.origin.y
            // 노가다를 통해 모든 기종에 적절한 크기를 설정함
            let newFrame = textFieldTopY - keyboardTopY/1.6
            transformView.frame.origin.y -= newFrame
        }
        
    }
                                                            
    
    private func keyboardWillDisappear(_ sender: Notification){
        if transformView.frame.origin.y != 0{
            transformView.frame.origin.y = 0
        }
    }
    
    
    func changeStatusBarBgColor(bgColor: UIColor?) {
            if #available(iOS 13.0, *) {
                let window = UIApplication.shared.windows.first
                let statusBarManager = window?.windowScene?.statusBarManager
                
                let statusBarView = UIView(frame: statusBarManager?.statusBarFrame ?? .zero)
                statusBarView.backgroundColor = bgColor
                
                window?.addSubview(statusBarView)
            } else {
                let statusBarView = UIApplication.shared.value(forKey: "statusBar") as? UIView
                statusBarView?.backgroundColor = bgColor
            }
        }
}


// MARK: - 확장 : UITextField

extension UITextField{
    @IBInspectable var wanryoAccesory: Bool{
        get{
            return self.wanryoAccesory
        }
        set(hasDone){
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        doneToolbar.backgroundColor = .white
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        self.resignFirstResponder()
    }
}


// MARK: - 확장 : UITextFieldDelegate

extension SignUp2ViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 
        // backspace 허용
        if let char = string.cString(using: String.Encoding.utf8){
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92{ return true }
        }
        
        guard let text = textField.text else { return false }
        
        if textField == textFieldName{ return text.count < 10 }
        if textField == textFieldBirth{ return text.count < 8 }
        if textField == textFieldPhoneNo{ return text.count < 11 }
        
        return true
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
