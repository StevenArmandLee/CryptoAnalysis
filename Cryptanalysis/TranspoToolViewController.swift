//
//  TranspoToolViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 7/8/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import UIKit

class TranspoToolViewController: UIViewController, UITextFieldDelegate {

  
    @IBOutlet weak var savedLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var periodTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    var currentText = ""
    var currentIndex = 0
    var transpoToolModel: TranspoToolModel = TranspoToolModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        periodTextField.delegate = self
        currentText = globalOriginalText
        textView.text = transpoToolModel.analyzeByPeriod(currentText, period: 0)
        dispatch_async(dispatch_get_main_queue(), {
            self.textView.scrollRangeToVisible(NSMakeRange(0, 0))
        })
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        savedLabel.layer.cornerRadius = 5
        self.savedLabel.alpha = 0
        self.savedLabel.layer.masksToBounds = true
        
        
    }
    
       @IBAction func onChange(sender: AnyObject) {
        
        if periodTextField.text != "" {
            currentIndex = Int(periodTextField.text!)!
            if (globalOriginalText.stringByReplacingOccurrencesOfString("\t", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "").stringByReplacingOccurrencesOfString("\n", withString: "").characters.count >= currentIndex){
                textView.text = transpoToolModel.analyzeByPeriod(currentText, period: currentIndex)
                dismissKeyboard()
                textView.setContentOffset(CGPointZero, animated: true)
            }
                
            else {
                let attributedString = NSAttributedString(string: "Alert", attributes: [
                    NSFontAttributeName : UIFont.systemFontOfSize(20),
                    NSForegroundColorAttributeName : UIColor.redColor()
                    ])
                let alert = UIAlertController(title: "", message: "Invalid inputs",  preferredStyle: .Alert)
                
                alert.setValue(attributedString, forKey: "attributedTitle")
                alert.addAction(UIAlertAction(title:"Close",style: UIAlertActionStyle.Default, handler:nil))
                presentViewController(alert, animated: true, completion: nil)
            }

        }
        
    }
    
 
    @IBAction func onSave(sender: AnyObject) {
        currentText = transpoToolModel.analyzeByPeriod(currentText, period: currentIndex)
        UIView.animateWithDuration(1.0) {
            self.savedLabel.alpha = 1.0
            self.savedLabel.alpha = 0
        }
    
        
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        view.endEditing(true)
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,replacementString string: String) -> Bool {
        
        // Create an `NSCharacterSet` set which includes everything *but* the digits
        let inverseSet = NSCharacterSet(charactersInString:"0123456789").invertedSet
        
        // At every character in this "inverseSet" contained in the string,
        // split the string up into components which exclude the characters
        // in this inverse set
        let components = string.componentsSeparatedByCharactersInSet(inverseSet)
        
        // Rejoin these components
        let filtered = components.joinWithSeparator("")  // use join("", components) if you are using Swift 1.2
        
        // If the original string is equal to the filtered string, i.e. if no
        // inverse characters were present to be eliminated, the input is valid
        // and the statement returns true; else it returns false
        return string == filtered
    }
}
