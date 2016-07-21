//
//  AutoGrowngTextView.swift
//  Cryptanalysis
//
//  Created by steven lee on 17/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import UIKit

class AutoGrowingTextView: UITextView {
    
    var maxHeight: CGFloat?
    var minHeight: CGFloat?
    
    private var heightConstraint: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.commonInit()
    }
    
    private func commonInit() {
        // If we are using auto layouts, than get a handler to the height constraint.
        self.constraints.forEach {
            if $0.firstAttribute == NSLayoutAttribute.Height {
                self.heightConstraint = $0
                return
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.heightConstraint != nil {
            var intrinsicSize = self.intrinsicContentSize()
            
            if let minHeight = self.minHeight {
                intrinsicSize.height = max(intrinsicSize.height, minHeight)
            }
            
            if let maxHeight = self.maxHeight {
                intrinsicSize.height = min(intrinsicSize.height, maxHeight)
            }
            
            self.heightConstraint?.constant = intrinsicSize.height
            UIView.animateWithDuration(0.2, animations: {
                self.layoutIfNeeded()
            })
        }
    }
    
    override func intrinsicContentSize() -> CGSize {
        var intrinsicContentSize = self.contentSize
        
        intrinsicContentSize.width += (self.textContainerInset.left + self.textContainerInset.right ) / 2.0;
        intrinsicContentSize.height += (self.textContainerInset.top + self.textContainerInset.bottom) / 2.0;
        
        return intrinsicContentSize
    }
}
