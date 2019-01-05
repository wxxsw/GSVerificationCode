//
//  GSVerificationCodeView.swift
//  GSVerificationCodeView
//
//  Created by Gesen on 2019/1/5.
//  Copyright © 2019 Gesen. All rights reserved.
//

import UIKit

public protocol GSVerificationCodeViewDelegate: NSObjectProtocol {
    
    func verificationCode(_ view: GSVerificationCodeView, didChange code: String)
    
}

public class GSVerificationCodeView: UIView {
    
    public weak var delegate: GSVerificationCodeViewDelegate?
    
    @IBInspectable public var fontSize: CGFloat {
        get { return font.pointSize }
        set { font = .systemFont(ofSize: newValue); updateIB() }
    }
    
    @IBInspectable public var maxLength: Int = 4 {
        didSet { updateIB() }
    }
    
    @IBInspectable public var spacing: CGFloat = 10 {
        didSet { updateIB() }
    }
    
    @IBInspectable public var textColor: UIColor = .black {
        didSet { updateIB() }
    }
    
    public var font: UIFont = .systemFont(ofSize: 16)
    
    private let textField = UITextField()
    private let coverView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        configureInit()
    }
    
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        textField.frame = bounds
        coverView.frame = bounds
    }
    
    @discardableResult
    public override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }

}

extension GSVerificationCodeView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard
            let oldString = textField.text,
            let range = Range(range, in: oldString)
            else { return false }
        
        let newString = oldString.replacingCharacters(in: range, with: string)
        let shouldChange = newString.count <= maxLength
        
        if newString.count >= maxLength {
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                self.textField.resignFirstResponder()
            }
        }
        
        if shouldChange {
            self.delegate?.verificationCode(self, didChange: newString)
        }
        
        return shouldChange
    }
    
}

private extension GSVerificationCodeView {
    
    func configureInit() {
        configureTextField()
        configureCoverView()
    }
    
    func configureTextField() {
        textField.adjustsFontSizeToFitWidth = false
        textField.allowsEditingTextAttributes = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.keyboardType = .numberPad
        addSubview(textField)
    }
    
    func configureCoverView() {
        coverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        addSubview(coverView)
    }
    
}

private extension GSVerificationCodeView {
    
    @objc func tap() {
        textField.becomeFirstResponder()
    }
    
    func updateIB() {
        textField.defaultTextAttributes = [
            .font: font,
            .kern: spacing,
            .foregroundColor: textColor
        ]
    }
    
}
