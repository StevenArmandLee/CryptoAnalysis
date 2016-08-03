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
        
    }
    
    
    @IBAction func onButton(sender: UIButton) {
        resultText = sender.currentTitle!
            }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var toolsContentVC: ToolsContentViewController = (segue.destinationViewController as! ToolsContentViewController)
        toolsContentVC.receivedText = resultText
    }
    
    
    
}