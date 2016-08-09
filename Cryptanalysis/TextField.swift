//
//  TextField.swift
//  Cryptanalysis
//
//  Created by steven lee on 9/8/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

class TextField : UITextField {
    override func caretRectForPosition(position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    override func selectionRectsForRange(range: UITextRange) -> [AnyObject] {
        return []
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == #selector(NSObject.copy(_:)) || action == #selector(NSObject.selectAll) || action == #selector(NSObject.paste) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
