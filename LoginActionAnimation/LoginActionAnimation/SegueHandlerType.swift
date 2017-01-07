//
//  SegueHandlerType.swift
//  LoginActionAnimation
//
//  Created by lyxia on 2017/1/7.
//  Copyright © 2017年 lyxia. All rights reserved.
//

import UIKit

protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    
    func segueIdentifierForSegue(_ segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier, let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
            fatalError("Unknown segue: \(segue))")
        }
        
        return segueIdentifier
    }
    
    func performSegue(_ segueIdentifier: SegueIdentifier) {
        self.performSegue(withIdentifier: segueIdentifier.rawValue, sender: nil)
    }
}
