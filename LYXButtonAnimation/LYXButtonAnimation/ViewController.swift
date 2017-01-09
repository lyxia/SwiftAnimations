//
//  ViewController.swift
//  LYXButtonAnimation
//
//  Created by lyxia on 2017/1/9.
//  Copyright © 2017年 lyxia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonAnimation: LYXButtonAnimation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        buttonAnimation.button.setTitle("title", for: .normal)
    }

}

