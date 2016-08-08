//
//  MonoDecryption.swift
//  Cryptanalysis
//
//  Created by steven lee on 11/6/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import UIKit


class MonoDecryptionController: UIViewController
{
    var receivedString = ""
    private var monoDecryption: MonoDecryptionModel = MonoDecryptionModel()
    private var affineDecryption :AffineDecryption = AffineDecryption()
 
    
    
    var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var autoDecryptionButton: UIButton!
    @IBOutlet weak var clearKeysButton: UIButton!
    @IBOutlet weak var autoFillButton: UIButton!
    @IBOutlet var segmentOutletMono: UISegmentedControl!
    
    @IBOutlet weak var showKeysButton: UIButton!
    @IBOutlet var wordFromTextField: UITextField!
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet var wordToTextField: UITextField!
    @IBAction func autoFillButtonAction(sender: AnyObject) {
        let defaultLetters = "abcdefghijklmnopqrstuvwxyz"
        let wordFrom = wordFromTextField.text!
        let wordTo = wordToTextField.text!
        if wordFrom != ""{
            let uniqueWordFrom = monoDecryption.removeDuplicateLetterFromString(wordFrom)
            let filledWordFrom = monoDecryption.autoFillKeyString(uniqueWordFrom)
            wordFromTextField.text = filledWordFrom
        }else{
            wordFromTextField.text = defaultLetters
        }
        if wordTo != ""{
            let uniqueWordTo = monoDecryption.removeDuplicateLetterFromString(wordTo)
            let filledWordTo = monoDecryption.autoFillKeyString(uniqueWordTo)
            wordToTextField.text = filledWordTo
        }else{
            wordToTextField.text = defaultLetters
        }
    }
    @IBAction func changeButtonAction(sender: AnyObject) {
        if receivedString == "Substitution"{
            changeMono()
        }
        else {
            changeAffine()
        }
            }
    
    func changeMono(){
        let wordFrom = wordFromTextField.text!
        let wordTo = wordToTextField.text!
        if wordTo != ""{
            if wordFrom != ""{
                if segmentOutletMono.selectedSegmentIndex == 0{
                    monoDecryption.insertKeyToDictionaryStream(wordFrom, userValue: wordTo)
                    resultTextView.text = monoDecryption.applyReplaceUsingDictionaryStream(globalModifiedText)
                }else if segmentOutletMono.selectedSegmentIndex == 1{
                    monoDecryption.insertKeyToDictionaryBlock(wordFrom, userValue: wordTo)
                    resultTextView.text = monoDecryption.applyReplaceUsingDictionaryBlock(globalModifiedText)                }
            }else{
                //PRINT IF RIGHT BOX EMPTY
            }
        }else{
            //PRINT IF LEFT BOX EMPTY
        }
        wordFromTextField.text = ""
        wordToTextField.text = ""

    }
    
    func changeAffine(){
        let alphaKey = wordFromTextField.text!
        let betaKey = wordToTextField.text!
        if alphaKey != "" && Int(alphaKey) != nil{
            if betaKey != "" && Int(betaKey) != nil{
                if Int(alphaKey)! % 2 != 0 && Int(alphaKey)! != 13 && Int(alphaKey)! < 26{
                    if Int(betaKey)! < 26{
                        if segmentOutletMono.selectedSegmentIndex == 0{
                            resultTextView.text = affineDecryption.applyAffineEncryptionUsingKey(resultTextView.text.uppercaseString, alphaKey: Int(alphaKey)!, betaKey :Int(betaKey)!)
                        }else if segmentOutletMono.selectedSegmentIndex == 1{
                            resultTextView.text = affineDecryption.applyAffineDecryptionUsingKey(resultTextView.text.uppercaseString, alphaKey: Int(alphaKey)!, betaKey: Int(betaKey)!)
                        }
                    }else{
                        //PRINT BETA KEY CANT EXCEED 26
                    }
                }else{
                    //PRINT ALPHA KEY CANT BE EVEN NUMBER OR 13 OR EXCEED 26
                }
            }else{
                // PRINT IF RIGHT BOX EMPTY OR NOT NUMBER
            }
        }else{
            //PRINT IF LEFT BOX EMPTY OR NOT NUMBER
        }

    }
    func addActivityIndicator() {
        
        
        
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
        
        
    }
    @IBAction func onChangeSegment(sender: AnyObject) {
        if(receivedString == "Substitution")
        {
            if segmentOutletMono.selectedSegmentIndex == 1
            {
                autoFillButton.hidden = true
            }
            else if segmentOutletMono.selectedSegmentIndex == 0
            {
                autoFillButton.hidden = false
            }
        }
    }
    func isSubstitution()
    {
        segmentOutletMono.setTitle("Stream", forSegmentAtIndex: 0)
        segmentOutletMono.setTitle("Block", forSegmentAtIndex: 1)
        
    }
    
    func isAffine()
    {
        segmentOutletMono.setTitle("Encrypt", forSegmentAtIndex: 0)
        segmentOutletMono.setTitle("Decrypt", forSegmentAtIndex: 1)
        autoFillButton.hidden = true
        clearKeysButton.hidden = true
        showKeysButton.hidden = true
        
        
    }
    
    func isAffineOrSubstitution(cipherType: String)
    {
        if(cipherType == "Substitution")
        {
            isSubstitution()
        }
        else{
            isAffine()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordFromTextField.autocorrectionType = .No
        wordToTextField.autocorrectionType = .No
        isAffineOrSubstitution(receivedString)
        resultTextView.text = globalModifiedText
        resultTextView.layer.borderWidth=1
        resultTextView.layer.borderColor=UIColor.blackColor().CGColor
        // do any additional setup after loading the view, typically from a nib.
        
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
    
    
    @IBAction func onAutoDecryption(sender: AnyObject) {
        self.addActivityIndicator()
        var autoDecryptionModel: AutoDecryptionModel = AutoDecryptionModel()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            //All background running put here
            
            if(self.receivedString == "Affine") {
                autoDecryptionModel.generateAutoDecryptAffine(globalOriginalText)
                
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
    
    @IBAction func onClearText(sender: AnyObject) {
        if segmentOutletMono.selectedSegmentIndex == 0 {
            monoDecryption.clearStreamDictionary()
        }
        else {
            monoDecryption.clearBlockDictionary()
        }
    }
    
    
    @IBAction func onShowKeys(sender: AnyObject) {
        
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("keysPopUp") as! keyPopUpViewController
        if(segmentOutletMono.selectedSegmentIndex == 0) {
            popOverVC.key = monoDecryption.getStreamDictionary()
        }
        else {
            popOverVC.key = monoDecryption.getBlockDictionary()
        }
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)


    }
    
  
    
}