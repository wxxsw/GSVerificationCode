//
//  ViewController.swift
//  GSVerificationCode
//
//  Created by Gesen on 01/05/2019.
//  Copyright (c) 2019 Gesen. All rights reserved.
//

import UIKit
import GSVerificationCode

class ViewController: UIViewController {

    @IBOutlet weak var verificationCodeView: GSVerificationCodeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verificationCodeView.delegate = self
    }

}

extension ViewController: GSVerificationCodeViewDelegate {
    
    func verificationCode(_ view: GSVerificationCodeView, didChange code: String) {
        print(code)
    }
    
}

