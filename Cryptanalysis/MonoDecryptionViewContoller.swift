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
    private var monoDecryption: MonoDecryptionModel = MonoDecryptionModel()
    private var affineDecryption :AffineDecryption = AffineDecryption()
    private var optionFlagMono :Int = 0
    private var optionFlagAffine :Int = 0
    
    @IBOutlet var segmentOutletAffine: UISegmentedControl!
    @IBAction func segmentEncryptDecrypt(sender: AnyObject) {
        switch(self.segmentOutletAffine.selectedSegmentIndex){
        case 0 : optionFlagAffine = 0
        break;
        case 1 : optionFlagAffine = 1
        break;
        default : optionFlagAffine = 0
        break;
        }    }
    @IBOutlet var segmentOutletMono: UISegmentedControl!
    @IBAction func segmentStreamBlock(sender: AnyObject) {
        switch(self.segmentOutletMono.selectedSegmentIndex){
        case 0 : optionFlagMono = 0
        break;
        case 1 : optionFlagMono = 1
        break;
        default : optionFlagMono = 0
        break;
        }
    }
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
        let wordFrom = wordFromTextField.text!
        let wordTo = wordToTextField.text!
        if wordTo != ""{
            if wordFrom != ""{
                if optionFlagMono == 0{
                    monoDecryption.insertKeyToDictionaryStream(wordFrom, userValue: wordTo)
                    resultTextView.text = monoDecryption.applyReplaceUsingDictionaryStream(globalModifiedText)
                }else if optionFlagMono == 1{
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
    
    
    @IBAction func affineDecryption(sender: AnyObject) {
        let alphaKey = wordFromTextField.text!
        let betaKey = wordToTextField.text!
        if alphaKey != "" && Int(alphaKey) != nil{
            if betaKey != "" && Int(betaKey) != nil{
                if Int(alphaKey)! % 2 != 0 && Int(alphaKey)! != 13 && Int(alphaKey)! < 26{
                    if Int(betaKey)! < 26{
                        if optionFlagAffine == 0{
                            resultTextView.text = affineDecryption.applyAffineEncryptionUsingKey(resultTextView.text.uppercaseString, alphaKey: Int(alphaKey)!, betaKey :Int(betaKey)!)
                        }else if optionFlagAffine == 1{
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}