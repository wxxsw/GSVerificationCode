//
//  GSVerificationCodeView.swift
//  GSVerificationCodeView
//
//  Created by Gesen on 2019/1/5.
//  Copyright © 2019 Gesen. All rights reserved.
//

import UIKit

class GSVerificationCodeView: UIView {
    
    @IBInspectable var font: UIFont = .systemFont(ofSize: 16)
    @IBInspectable var maxLength: Int = 4
    @IBInspectable var spacing: CGFloat = 10
    @IBInspectable var textColor: UIColor = .black
    
    private let textField = UITextField()
    private let coverView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureInit()
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.frame = bounds
        coverView.frame = bounds
    }

}

extension GSVerificationCodeView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldString = textField.text, let range = Range(range, in: oldString) else {
            return false
        }
        let newString = oldString.replacingCharacters(in: range, with: string)
        if newString.count >= maxLength {
            DispatchQueue.main.async { [weak textField] in textField?.resignFirstResponder() }
        }
        return newString.count <= maxLength
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
        textField.defaultTextAttributes = [
            NSAttributedString.Key.font: font,
            .kern: spacing,
            .foregroundColor: textColor
        ]
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
    
}
