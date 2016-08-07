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
    
    @IBOutlet weak var autoDecryptionButton: UIButton!
    var receivedString = ""
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var keyField: UITextField!
    private var model : PolyDecryptionModel = PolyDecryptionModel()
    @IBOutlet weak var typeOfCipherSegment: UISegmentedControl!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    var activityIndicator: UIActivityIndicatorView!
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
        if receivedString == "Polyalphabetic"{
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
        else {
            typeOfCipherSegment.hidden = true
            changeButton.hidden = false
            leftButton.hidden = true
            rightButton.hidden = true
        }
    }
    
    
    func addActivityIndicator() {
        
        self.leftButton.enabled = false
        self.rightButton.enabled = false
        self.changeButton.enabled = false
        self.typeOfCipherSegment.enabled = false
        
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
        self.leftButton.enabled = true
        self.rightButton.enabled = true
        self.changeButton.enabled = true
        self.typeOfCipherSegment.enabled = true
       
    }
    
    //change the function to onChange
    @IBAction func buttonPressed(sender: UIButton) {
        if(receivedString == "Polyalphabetic") {
            changePoly()
        }
        else if receivedString == "Transposition" {
            changeTranspo()
        }
        else if receivedString == "Playfair" {
            changePlayfair()
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
    
    func changePoly()
    {
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
    
    func changeTranspo() {
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
    
    func changePlayfair()
    {
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
        
    @IBAction func onAutoDecryption(sender: AnyObject) {
        self.addActivityIndicator()
        var autoDecryptionModel: AutoDecryptionModel = AutoDecryptionModel()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            //All background running put here
            
            if(self.receivedString == "Polyalphabetic") {
                if(self.typeOfCipherSegment.selectedSegmentIndex == 0) {
                    autoDecryptionModel.generateAutoDecryptPoly(globalOriginalText, isBeaufort: false)
                }
                else {
                    autoDecryptionModel.generateAutoDecryptPoly(globalOriginalText, isBeaufort: true)
                }
            }
            else if self.receivedString == "Transposition" {
            }
            else if self.receivedString == "Playfair" {
               
            }
            else if self.receivedString == "Shift" {
             
                autoDecryptionModel.generateAutoDecryptShift(globalOriginalText.uppercaseString)
            }
            dispatch_async(dispatch_get_main_queue()){
                [weak self] in
                self?.removeActivityIndicator()
                let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("informationPopUp") as! popupViewController
                popOverVC.key = autoDecryptionModel.getKeyword()
                self!.addChildViewController(popOverVC)
                popOverVC.view.frame = self!.view.frame
                self!.view.addSubview(popOverVC.view)
                popOverVC.didMoveToParentViewController(self)
                            }
        }
    }
    
    @IBAction func onSegment(sender: UISegmentedControl) {
        if receivedString == "Polyalphabetic" {
            

        }
            }
    
}