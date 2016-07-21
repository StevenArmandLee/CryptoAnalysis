//
//  DecryptViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 11/6/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import UIKit


class DecryptViewController: UIViewController
{
    var isMono = false
    var decryptionType = ""
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
   
    
    @IBAction func onButton(sender: UIButton) {
        if sender.currentTitle == "Mono"{
            isMono = true
        }
        else{
            isMono = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDecryptionType(sender: UIButton) {
        decryptionType = sender.currentTitle!
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if isMono == false{
            var polyDecryptoinVC: PolyDecryptionController = (segue.destinationViewController as! PolyDecryptionController)
            polyDecryptoinVC.receivedString = decryptionType
        }
        
        
    }
}