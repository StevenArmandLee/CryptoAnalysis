//
//  FirstViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 11/5/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import UIKit


var globalOriginalText: String=""
var globalModifiedText: String=""

class InputViewController: UIViewController, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var cipherPickerTextField: UITextField!
    @IBOutlet weak var originalText: UITextView!
    @IBOutlet var viewController: UIView!
    @IBOutlet weak var BottomConstraint: NSLayoutConstraint!
    
    var cipherPickerOption = ["1","2"] //TODO change to name of cipher
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var pickerView = UIPickerView()
        pickerView.delegate = self
        cipherPickerTextField.inputView = pickerView
        
        let origImage = UIImage(named: "info");
        let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        infoButton.setImage(tintedImage, forState: .Normal)
        infoButton.tintColor = UIColor.redColor() //TODO change the color when disabled, need to decide what color is good
        
        originalText.delegate = self
        originalText.layer.borderWidth=1
        originalText.layer.borderColor = UIColor.lightGrayColor().CGColor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.Available {
            registerForPreviewingWithDelegate(self, sourceView: view)
        } else {
            print("#D touch not available")
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cipherPickerOption.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cipherPickerOption[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cipherPickerTextField.text = cipherPickerOption[row]
    }
    
    
   
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
   
    func textViewDidChange(textView: UITextView) {
        globalOriginalText = originalText.text
        globalModifiedText = globalOriginalText
        
    }

    @IBAction func clearText(sender: AnyObject) {
        originalText.text=""
        globalOriginalText = originalText.text
        globalModifiedText = globalOriginalText
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showInfoPopup(sender: UIButton) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("informationPopUp") as! popupViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
        
    }

}


extension InputViewController: UIViewControllerPreviewingDelegate{
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let peekViewController = storyboard?.instantiateViewControllerWithIdentifier("informationPopUp") as! popupViewController
        //TODO create new view controller and show the information
        return peekViewController
    }
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        
    }
}


