//
//  CKTextField.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/20/24.
//

import UIKit

protocol CKTextFieldDelegate: AnyObject {
    // 텍스트필드 text의 유효성 판별
    func ckTextField(textToCheckCondition text: String) -> (isValid: Bool, placeholderToAppear: String)
}

// Text의 조건을 검사하는 텍스트필드(Condition Check)
@IBDesignable class CKTextField: UITextField {
    
    enum AnimationType: Int {
        case textEntry
        case textDisplay
    }
    
    // 텍스트필드가 비활성화일 때
    @IBInspectable var inactiveColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    
    // 텍스트필드가 활성화되어있을 때
    var activeColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    
    // condition 만족 시 보더 컬러
    @IBInspectable var validBorderColor: UIColor = .red
    
    // condition 불만족 시 보더 컬러
    @IBInspectable var invalidBorderColor: UIColor = .red
    
    @IBInspectable var placeholderColor: UIColor? = .lightGray {
        didSet {
            updatePlaceholder()
        }
    }
    
    // 텍스트필드 폰트 대비 placeholder 비율
    @IBInspectable var placeholderFontScale: CGFloat = 1 {
        didSet {
            updatePlaceholder()
        }
    }
    
    override var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override var bounds: CGRect {
        didSet {
            updateBorder()
            updatePlaceholder()
        }
    }
    
    weak var ckDelegate: CKTextFieldDelegate?
    private let placeholderLabel = UILabel()
    var animationCompletionHandler: ((_ type: AnimationType) -> Void)?
    
    private var originalPlaceholder = ""
    
    private let borderThickness: (active: CGFloat, inactive: CGFloat) = (active: 2, inactive: 0.5)
    private let placeholderInsets = CGPoint(x: 0, y: 6)
    private let textFieldInsets = CGPoint(x: 0, y: 12)
    private let inactiveBorderLayer = CALayer()
    private let activeBorderLayer = CALayer()
    private var activePlaceholderPoint: CGPoint = CGPoint.zero
    
    // MARK: - functions
    
    // text 유효성에 따른 텍스트필드 반영
    private func updateByCondition() {
        let result = ckDelegate?.ckTextField(textToCheckCondition: text!)
        
        if !text!.isEmpty {
            activeColor = result!.isValid ? validBorderColor: invalidBorderColor
            placeholderLabel.textColor = activeColor
            placeholderLabel.text = result!.placeholderToAppear
            placeholderLabel.sizeToFit()
        }
    }
    
    // rect에 따른 뷰 그리기
    func drawViewsForRect(_ rect: CGRect) {
        let frame = CGRect(origin: .zero, size: CGSize(width: rect.size.width, height: rect.size.height))
        
        placeholderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
        placeholderLabel.font = placeholderFontFromFont(font!)
        
        updateBorder()
        updatePlaceholder()
        
        layer.addSublayer(inactiveBorderLayer)
        layer.addSublayer(activeBorderLayer)
        addSubview(placeholderLabel)
    }
    
    // 텍스트필드 입력 시 애니메이션
    func animateViewsForTextEntry() {
        if text!.isEmpty {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .beginFromCurrentState,  animations: {
                self.placeholderLabel.frame.origin = CGPoint(x: 10, y: self.placeholderLabel.frame.origin.y)
                self.placeholderLabel.alpha = 0
            }) { _ in   // completion
                self.animationCompletionHandler?(.textEntry)
            }
        }
        
        updateByCondition()
        
        layoutPlaceholderInTextRect()
        placeholderLabel.frame.origin = activePlaceholderPoint
        
        UIView.animate(withDuration: 0.4, animations: {
            self.placeholderLabel.alpha = 1.0
        })
    }
    
    // 텍스트필드 입력 종료 시 애니메이션
    func animateViewsForTextDisplay() {
        if let text = text, text.isEmpty {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .beginFromCurrentState,  animations: {
                self.placeholderLabel.alpha = 1
            }) { _ in   // completion
                self.animationCompletionHandler?(.textDisplay)
            }
            
            self.layoutPlaceholderInTextRect()
            
            UIView.animate(withDuration: 0.4, animations: { [self] in
                updatePlaceholder()
                placeholderLabel.alpha = 1
            })
            
            activeBorderLayer.frame = self.rectForBorder(self.borderThickness.active, isFilled: false)
            inactiveBorderLayer.frame = self.rectForBorder(self.borderThickness.inactive, isFilled: true)
        }
    }
    
    // MARK: - Private
    
    private func updateBorder() {
        inactiveBorderLayer.frame = rectForBorder(borderThickness.inactive, isFilled: !isFirstResponder)
        inactiveBorderLayer.backgroundColor = inactiveColor?.cgColor
        
        activeBorderLayer.frame = rectForBorder(borderThickness.active, isFilled: isFirstResponder)
        activeBorderLayer.backgroundColor = activeColor?.cgColor
    }
    
    private func updatePlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.sizeToFit()
        layoutPlaceholderInTextRect()
        
        if isFirstResponder || !text!.isEmpty {
            animateViewsForTextEntry()
        }
    }
    
    private func placeholderFontFromFont(_ font: UIFont) -> UIFont {
        
        let smallerFont = UIFont(descriptor: font.fontDescriptor, size: font.pointSize * placeholderFontScale)
        return smallerFont
    }
    
    private func rectForBorder(_ thickness: CGFloat, isFilled: Bool) -> CGRect {
        
        if isFilled {
            return CGRect(origin: CGPoint(x: 0, y: frame.height - thickness), size: CGSize(width: frame.width, height: thickness))
        } else {
            return CGRect(origin: CGPoint(x: 0, y: frame.height - thickness), size: CGSize(width: 0, height: thickness))
        }
    }
    
    
    private func layoutPlaceholderInTextRect() {
        
        let textRect = self.textRect(forBounds: bounds)
        
        var originX = textRect.origin.x
        
        switch textAlignment {
        case .center:
            originX += textRect.size.width / 2 - placeholderLabel.bounds.width / 2
        case .right:
            originX += textRect.size.width - placeholderLabel.bounds.width
        default:
            break
        }
        
        placeholderLabel.frame = CGRect(x: originX, y: textRect.height / 2, width: placeholderLabel.bounds.width, height: placeholderLabel.bounds.height)
        
        activePlaceholderPoint = CGPoint(x: placeholderLabel.frame.origin.x, y: placeholderLabel.frame.origin.y + placeholderLabel.frame.size.height + placeholderInsets.y * 3)
    }
    
    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.borderStyle = .none
    }
    
    override func draw(_ rect: CGRect) {
        
        guard isFirstResponder == false else { return }
        drawViewsForRect(rect)
    }
    
    override func drawPlaceholder(in rect: CGRect) {
        // 기존 placeholder를 안보이게 하려고 오버라이딩만
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
}

// MARK: - UITextField Observing

extension CKTextField {

        override func willMove(toSuperview newSuperview: UIView!) {
            if newSuperview != nil {
                NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidEndEditing), name: UITextField.textDidEndEditingNotification, object: self)
                
                NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidBeginEditing), name: UITextField.textDidBeginEditingNotification, object: self)
            } else {
                NotificationCenter.default.removeObserver(self)
            }
        }
        
        // 텍스트필드 입력 시작 시
        @objc func textFieldDidBeginEditing() {
            animateViewsForTextEntry()
        }
        
        // 텍스트필드 입력 창 나갔을 때
        @objc func textFieldDidEndEditing() {
            animateViewsForTextDisplay()
        }
        
        // IB에서 그리기
        override func prepareForInterfaceBuilder() {
            drawViewsForRect(frame)
        }
}
