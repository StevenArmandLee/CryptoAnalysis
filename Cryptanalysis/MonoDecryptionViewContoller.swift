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
    private var monoDecryption: MonoDecryption = MonoDecryption()
    
    @IBOutlet var wordFromTextField: UITextField!
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet var wordToTextField: UITextField!
    @IBAction func changeButtonAction(sender: AnyObject) {
        if let wordTo = wordToTextField.text{
            if let wordFrom = wordFromTextField.text{
                monoDecryption.insertKeyToDictionary(wordFrom, userValue: wordTo)
                resultTextView.text = monoDecryption.applyReplaceUsingDictionary(globalModifiedText)
            }
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
