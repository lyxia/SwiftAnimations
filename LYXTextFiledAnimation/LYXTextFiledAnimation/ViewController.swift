//
//  ViewController.swift
//  LYXTextFiledAnimation
//
//  Created by lyxia on 2017/1/8.
//  Copyright © 2017年 lyxia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var tf: UITextField! {
        didSet {
            tf.delegate = self
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("dddd")
    }
}

