//
//  LYXTextFieldAnimation.swift
//  LYXTextFiledAnimation
//
//  Created by lyxia on 2017/1/8.
//  Copyright © 2017年 lyxia. All rights reserved.
//

import UIKit

class LYXTextFieldAnimation: UIView, UITextFieldDelegate, XIBViewType {
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addNotification()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addNotification()
    }
    
    @IBOutlet weak var contentView: UIView!
    override func willMove(toSuperview newSuperview: UIView?) {
        if self.contentView == nil {
            configContentView()
        }
    }
    
    deinit {
        removeNotification()
    }
    
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(_:)), name: Notification.Name.UITextFieldTextDidChange, object: textField)
    }
    
    func removeNotification() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UITextFieldTextDidChange, object: textField)
    }
    
    // MARK: property
    @IBOutlet weak var placeholderBottomLayout: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField! {
        didSet {
            if textField != nil {
                textField.delegate = self
            }
        }
    }
    @IBOutlet weak var undelayLineWidthLayout: NSLayoutConstraint!
    
    
    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if placeholderBottomLayout.constant == -3 {
            placeholderBottomLayout.constant = -textField.bounds.height - 3
            self.contentView.setNeedsLayout()
            UIView.animate(withDuration: 0.55) {
                self.contentView.layoutIfNeeded()
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text!.isEmpty {
            placeholderBottomLayout.constant = -3
            self.contentView.setNeedsLayout()
            UIView.animate(withDuration: 0.55) {
                self.contentView.layoutIfNeeded()
            }
        }
    }
    
    private var preText: String?
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        preText = textField.text
        return true
    }
    
    func textFieldDidChange(_ notification: Notification) {
        if preText == nil || preText!.isEmpty {
            if let text = textField.text, !text.isEmpty {
                undelayLineWidthLayout.constant = self.bounds.width
                self.contentView.setNeedsLayout()
                UIView.animate(withDuration: 0.55) {
                    self.contentView.layoutIfNeeded()
                }
            }
        }
        
        if preText != nil && !preText!.isEmpty {
            if textField.text == nil || textField.text!.isEmpty {
                undelayLineWidthLayout.constant = 0
                self.contentView.setNeedsLayout()
                UIView.animate(withDuration: 0.55) {
                    self.contentView.layoutIfNeeded()
                }
            }
        }
        
    }
    
}
