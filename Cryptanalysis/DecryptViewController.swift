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
    
    @IBOutlet weak var buttons: UIButton!
    var isMono = false
    var decryptionType = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons.imageView?.contentMode = UIViewContentMode.ScaleToFill
    }
    
   
    
    @IBAction func onButton(sender: UIButton) {
        if sender.currentTitle == "Substitution" || sender.currentTitle == "Affine"{
            isMono = true
        }
        else{
            isMono = false
        }
         decryptionType = sender.currentTitle!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if isMono == false{
            var polyDecryptoinVC: PolyDecryptionController = (segue.destinationViewController as! PolyDecryptionController)
            polyDecryptoinVC.receivedString = decryptionType
        }
        else{
            var substitutionDecryptoinVC: MonoDecryptionController = (segue.destinationViewController as! MonoDecryptionController)
            substitutionDecryptoinVC.receivedString = decryptionType
        }
        
        
    }
}