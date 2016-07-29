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
    
    var receivedString = ""
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var keyField: UITextField!
    private var model : PolyDecryptionModel = PolyDecryptionModel()
    @IBOutlet weak var typeOfCipherSegment: UISegmentedControl!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var rightButton: UIButton!
    private var shiftModel : ShiftDecryptionModel = ShiftDecryptionModel()
    
    private var transpoModel : TranspositionDecryptionModel = TranspositionDecryptionModel()
    
    private var playfairModel : PlayfairDecryptionModel = PlayfairDecryptionModel()
    
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
        hideElements()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideElements(){
        if receivedString == "Poly"{
            typeOfCipherSegment.hidden = false
            changeButton.hidden = false
            leftButton.hidden = true
            rightButton.hidden = true
            
        }
        else if receivedString == "Shift"{
            typeOfCipherSegment.hidden = true
            changeButton.hidden = true
            leftButton.hidden = false
            rightButton.hidden = false
        }
    }
    
    //change the function to onChange
    @IBAction func buttonPressed(sender: UIButton) {
        
        let ctext = globalModifiedText.uppercaseString
        let key = keyField.text!.uppercaseString
        let type = typeOfCipherSegment.selectedSegmentIndex
        if(keyField.text == ""){
            
        }
       else if model.checkKey(key) != false {
            let ptext = model.decryptionButton(ctext, key: key, type: type)
            resultTextView.text = ptext
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

    @IBAction func onShift(sender: UIButton) {
        
        let ctext = globalModifiedText.uppercaseString
        
        let key = keyField.text
        let type = sender.currentTitle
        
        if shiftModel.checkKey(key!) != false {
            let ptext = shiftModel.decryptionButton(ctext, offset: key!, type: type!)
            resultTextView.text = ptext
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
    
    @IBAction func transpoButton(sender: UIButton) {
        let ctext = globalModifiedText.uppercaseString
        let key = keyField.text!.uppercaseString
        
        if transpoModel.checkKey(key) != false {
            let ptext = transpoModel.decryptionButton(ctext, key: key)
            resultTextView.text = ptext
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
    
    @IBAction func playfairButton(sender: UIButton) {
        let ctext = globalModifiedText.lowercaseString
        let key = keyField.text!.lowercaseString
        
        if playfairModel.checkKey(key) != false {
            let ptext = playfairModel.decryptionButton(ctext, key: key)
            resultTextView.text = ptext
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