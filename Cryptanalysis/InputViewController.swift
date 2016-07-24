//
//  FirstViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 11/5/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import UIKit
import TesseractOCR
import GPUImage


var globalOriginalText: String=""
var globalModifiedText: String=""

class InputViewController: UIViewController, UITextViewDelegate, G8TesseractDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var originalText: UITextView!
    var tesseract:G8Tesseract = G8Tesseract(language:"eng")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalText.delegate = self
        originalText.layer.borderWidth=1
        originalText.layer.borderColor = UIColor.blackColor().CGColor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        tesseract.delegate = self
  
    }
    
    func showCamera(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate=self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        var image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        //to make threshold on the image
        var stillImageFilter: GPUImageAdaptiveThresholdFilter = GPUImageAdaptiveThresholdFilter();
        stillImageFilter.blurRadiusInPixels = 4.0
        //the end of threshold image
        var compressedImage = UIImageJPEGRepresentation(image, 0.6)
        
        
        
       
        scanTextFromPhoto(stillImageFilter.imageByFilteringImage(UIImage(data: compressedImage!)))
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func showAlbum(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate=self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func scanTextFromPhoto(photo: UIImage){
        tesseract.image = photo
        tesseract.recognize()
        globalOriginalText = tesseract.recognizedText
        globalModifiedText = globalOriginalText
        originalText.text=globalOriginalText
    }
    
    
    @IBAction func onCamera(sender: UIButton) {
        let actionSheet = UIAlertController(title: "Camera", message: nil, preferredStyle: .ActionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancle", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
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

