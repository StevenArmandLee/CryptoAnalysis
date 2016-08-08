//
//  ToolsViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 28/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import UIKit

class ToolsViewController: UIViewController {
    
    var resultText = ""
    var isTextChange = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    
    @IBAction func onButton(sender: UIButton) {
        resultText = sender.currentTitle!
            }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (resultText != "Transpo Tool" && resultText != "Playfair Tool")
        {
            var toolsContentVC: ToolsContentViewController = (segue.destinationViewController as! ToolsContentViewController)
            toolsContentVC.receivedText = resultText
        }
        
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        view.endEditing(true)
    }
    
    
}