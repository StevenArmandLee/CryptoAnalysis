//
//  keyPopViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 7/8/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import UIKit

class keyPopUpViewController: UIViewController {
    
    var key = ""
    
    
    @IBOutlet weak var keyTextField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        keyTextField.text = key
        self.showAnimate()
    }
    
    @IBAction func onClose(sender: UIButton) {
        self.removeAnimate()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    

    
}

