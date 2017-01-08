//
//  XIBViewType.swift
//  LYXTextFiledAnimation
//
//  Created by lyxia on 2017/1/8.
//  Copyright © 2017年 lyxia. All rights reserved.
//

import UIKit

protocol XIBViewType {
    var contentView: UIView! {get}
    
    func configContentView()
}

extension XIBViewType where Self: UIView {
    func configContentView() {
        Bundle.main.loadNibNamed("\(type(of:self))", owner: self, options: nil)
        self.addSubview(self.contentView)
        
        let top = self.contentView.topAnchor.constraint(equalTo: self.topAnchor)
        let left = self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor)
        let bottom = self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let right = self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor)
        self.addConstraints([top,left,bottom,right])
    }
}
