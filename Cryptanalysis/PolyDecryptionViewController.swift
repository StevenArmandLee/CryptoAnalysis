//
//  PolyDecryptionViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 11/6/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import UIKit


class PolyDecryptionController: UIViewController
{
    
    
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var keyField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTextView.text = globalModifiedText
        resultTextView.layer.borderWidth=1
        resultTextView.layer.borderColor=UIColor.blackColor().CGColor
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        resultTextView.text = globalModifiedText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var model : PolyDecryptionModel = PolyDecryptionModel()
    
 
    @IBAction func buttonPressed(sender: UIButton) {
        let ctext = globalModifiedText.lowercaseString
        let key = keyField.text!.lowercaseString
        let ptext = model.decryptionButton(ctext, key : key)
        resultTextView.text = ptext
    }
}