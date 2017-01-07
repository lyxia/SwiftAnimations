//
//  LoginViewController.swift
//  LoginActionAnimation
//
//  Created by lyxia on 2017/1/7.
//  Copyright © 2017年 lyxia. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, SegueHandlerType, AnimationTransitionFocusType {
    
    @IBOutlet weak var loginButton: UIButton!
    var focusRect: CGRect {
        return loginButton.frame
    }
    
    enum SegueIdentifier: String {
        case presentMain = "presentMain"
    }
    
    @IBAction func loginSuccessHandler(_ sender: Any) {
        performSegue(.presentMain)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue){
        case .presentMain:
            print("perform segue: \(segue)")
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        print("unwind segue: \(segue)")
    }
}
