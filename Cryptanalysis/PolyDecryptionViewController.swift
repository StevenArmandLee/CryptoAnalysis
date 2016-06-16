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
    @IBAction func buttonPressed(sender: UIButton) {
        let alphanumeric = "0123456789abcdefghijklmnopqrstuvwxyz"
        let ctext = globalModifiedText.lowercaseString
        let lengthOfCtext = ctext.characters.count
        
        let key = keyField.text!.lowercaseString
        let lengthOfKey = key.characters.count
        
        var ptext = String()
        
        for i in 0..<lengthOfCtext {
            let indexOfCtext = ctext.startIndex.advancedBy(i)
            let indexOfKey = key.startIndex.advancedBy(i%lengthOfKey)
            
            let ctextNum = findCharNum(ctext[indexOfCtext])
            
            if ctextNum == -1 {
                ptext.append(ctext[indexOfCtext])
            }
            else{
                let keyNum = findCharNum(key[indexOfKey])
                let pchar = alphanumeric.startIndex.advancedBy((ctextNum + keyNum) % 36)
                ptext.append(alphanumeric[pchar])
            }
        }
        
        
        resultTextView.text = ptext
        
    }
    
    func findCharNum(c : Character) -> Int
    {
        let alphanumeric = "0123456789abcdefghijklmnopqrstuvwxyz"
        var index = 0
        
        if let idx = alphanumeric.characters.indexOf(c) {
            index = alphanumeric.startIndex.distanceTo(idx)
        }else {
            // cannot find the char in the alphanumeric
            index = -1
        }
        
        return index
    }
}