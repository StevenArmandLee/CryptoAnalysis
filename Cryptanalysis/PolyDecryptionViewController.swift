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
    private var model : PolyDecryptionModel = PolyDecryptionModel()
    @IBOutlet weak var typeOfCipherSegment: UISegmentedControl!
    
    private var shiftModel : ShiftDecryptionModel = ShiftDecryptionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTextView.text = globalModifiedText
        resultTextView.layer.borderWidth=1
        resultTextView.layer.borderColor=UIColor.blackColor().CGColor
        // Do any additional setup after loading the view, typically from a nib.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        resultTextView.text = globalModifiedText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    
    @IBAction func onShift(sender: UIButton) {
        //you can check if the button is left or right by calling the sender
    }
    
    
    
    //change the function to onChange
    @IBAction func buttonPressed(sender: UIButton) {
        let ctext = globalModifiedText.lowercaseString
        let key = keyField.text!.lowercaseString
        let type = typeOfCipherSegment.selectedSegmentIndex
        
        if model.checkKey(key) != false {
            let ptext = model.decryptionButton(ctext, key: key, type: type)
            resultTextView.text = ptext
        }
        else {
            //TODO put an alert here, the message is "The key must not empty
            // or contains any symbol, space and number on it."
            
            // and then clear the keyField field
        }
        
        
    }
    
    @IBAction func onShift(sender: UIButton) {
        let ctext = globalModifiedText.lowercaseString
        let key = keyField.text
        let type = sender.currentTitle
        
        if shiftModel.checkKey(key!) != false {
            
            let ptext = shiftModel.decryptionButton(ctext, offset: key!, type: type!)
            resultTextView.text = ptext
        }
        else {
            //TODO put an alert here, the message is "The key must not
            // empty, minus integer
            // or contains any symbol, space and aplhabet on it."
            
            // and then clear the keyField field
        }
        
    }
}