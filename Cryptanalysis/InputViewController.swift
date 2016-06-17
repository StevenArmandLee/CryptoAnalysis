//
//  FirstViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 11/5/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import UIKit
import TesseractOCR


var globalOriginalText: String=""
var globalModifiedText: String=""

class InputViewController: UIViewController, UITextViewDelegate, G8TesseractDelegate {

    @IBOutlet weak var originalText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalText.delegate = self
        originalText.layer.borderWidth=1
        originalText.layer.borderColor = UIColor.blackColor().CGColor
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        
        
        var tesseract:G8Tesseract = G8Tesseract(language:"eng")
        //tesseract.charWhitelist = "0123456789"
        tesseract.delegate = self
        tesseract.image = UIImage(named: "test.jpg")
        tesseract.recognize()
        
        print(tesseract.recognizedText)
       // NSLog("%@", tesseract.recognizedText)
        
        
        
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


}

