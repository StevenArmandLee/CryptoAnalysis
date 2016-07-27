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
    private var optionFlag :Int = 0
    
    @IBOutlet var segmentOutlet: UISegmentedControl!
    @IBAction func segmentStreamBlock(sender: AnyObject) {
        switch(self.segmentOutlet.selectedSegmentIndex){
        case 0 : optionFlag = 0
        break;
        case 1 : optionFlag = 1
        break;
        default : optionFlag = 0
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
                if optionFlag == 0{
                    monoDecryption.insertKeyToDictionaryStream(wordFrom, userValue: wordTo)
                    resultTextView.text = monoDecryption.applyReplaceUsingDictionaryStream(globalModifiedText)
                }else if optionFlag == 1{
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
