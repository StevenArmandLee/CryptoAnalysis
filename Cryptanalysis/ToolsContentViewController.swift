//
//  ToolsContentViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 28/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//



class ToolsContentViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func onCompute(sender: UIButton) {
        let controller = storyboard?.instantiateViewControllerWithIdentifier("ToolsViewController") as! ToolsViewController!
        controller.resultText = "test"
        controller.isTextChange = true
        
            }
    
    
}
