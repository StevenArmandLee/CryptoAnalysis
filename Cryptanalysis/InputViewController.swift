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


class InputViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, G8TesseractDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var quizModel: QuizModel = QuizModel()
    
    @IBOutlet weak var symbolImage: UIImageView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var cipherPickerTextField: TextField!
    @IBOutlet weak var originalText: UITextView!
    @IBOutlet var viewController: UIView!
    var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var getCipherButton: UIButton!
    @IBOutlet weak var processButton: UIButton!
    @IBOutlet weak var clearTextButton: UIButton!
    @IBOutlet weak var usePhotoButton: UIButton!
    var cipherPickerOption = ["Affine","Monoalphabetic","Shift Left","Shift Right","Transposition","Playfair","Vigenere","Beaufort"]
    var imageToBeScanned: UIImage = UIImage()
    var key = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cipherPickerTextField.delegate = self
        
        cipherPickerTextField.allowsEditingTextAttributes = false
        
        getCipherButton.titleLabel?.minimumScaleFactor = 0.5
        getCipherButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        cipherPickerTextField.inputView = pickerView
        
        
        originalText.delegate = self
        originalText.layer.borderWidth=1
        originalText.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InputViewController.dismissKeyboard))
        pickerView.addGestureRecognizer(tap)
        view.addGestureRecognizer(tap)
        
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.Available {
            registerForPreviewingWithDelegate(self, sourceView: view)
        } else {
        
        }
        
        disableInitButtons()
    }
    
    override func viewWillAppear(animated: Bool) {
        originalText.text = globalOriginalText
    }
  
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,replacementString string: String) -> Bool {
        
        // Create an `NSCharacterSet` set which includes everything *but* the digits
        let inverseSet = NSCharacterSet(charactersInString:"").invertedSet
        
        // At every character in this "inverseSet" contained in the string,
        // split the string up into components which exclude the characters
        // in this inverse set
        let components = string.componentsSeparatedByCharactersInSet(inverseSet)
        
        // Rejoin these components
        let filtered = components.joinWithSeparator("")  // use join("", components) if you are using Swift 1.2
        
        // If the original string is equal to the filtered string, i.e. if no
        // inverse characters were present to be eliminated, the input is valid
        // and the statement returns true; else it returns false
        return string == filtered
    }
    
    func disableInitButtons() {
        let origImage = UIImage(named: "info");
        let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        infoButton.setImage(tintedImage, forState: .Disabled)
        infoButton.tintColor = UIColor.redColor()
        
        processButton.enabled = false
        processButton.backgroundColor = UIColor.whiteColor()
        processButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Disabled)
        
        infoButton.enabled = false
        
        getCipherButton.backgroundColor = UIColor.whiteColor()
        getCipherButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Disabled)
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
        self.view.endEditing(true)
        getCipherButton.enabled = true
    }
   
    func dismissKeyboard() {
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
            popOverVC.key = key
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMoveToParentViewController(self)
            dismissKeyboard()
    }
}


extension InputViewController: UIViewControllerPreviewingDelegate{
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if(infoButton.enabled == false)
        {
            return nil
        }
        let peekViewController = storyboard?.instantiateViewControllerWithIdentifier("keyPopViewController") as! keyPopViewController
        //TODO create new view controller and show the information
        peekViewController.key = key
        return peekViewController
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        
    }
    
    
    //OCR functions
    func showCamera(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate=self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        let image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        //to make threshold on the image
        let stillImageFilter: GPUImageAdaptiveThresholdFilter = GPUImageAdaptiveThresholdFilter();
        stillImageFilter.blurRadiusInPixels = 4.0
        //the end of threshold image
        let compressedImage = UIImageJPEGRepresentation(image, 0.6)
        imageToBeScanned = stillImageFilter.imageByFilteringImage(UIImage(data: compressedImage!))
        
        processButton.backgroundColor = UIColor.whiteColor()
        processButton.enabled = true
 
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
        self.addActivityIndicator()
        
        //multi thread code to process while showing loading screen during OCR
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            //All background running put here
            let tesseract:G8Tesseract = G8Tesseract(language:"eng")
            tesseract.engineMode = .CubeOnly
            tesseract.pageSegmentationMode = .Auto
            tesseract.image = photo.g8_blackAndWhite()
            tesseract.recognize()
            globalOriginalText = tesseract.recognizedText
            globalModifiedText = globalOriginalText
            dispatch_async(dispatch_get_main_queue()){
                [weak self] in
                //all code when the background finish running put here
                self!.originalText.text=globalOriginalText
                self!.removeActivityIndicator()
            }
        }
    }
    
    @IBAction func onUsePhoto(sender: UIButton) {
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

    @IBAction func onProcessPhoto(sender: UIButton) {
        scanTextFromPhoto(imageToBeScanned)
    }
    
    
    //activeIndicator functions
    func addActivityIndicator() {
        self.getCipherButton.enabled = false
        self.infoButton.enabled = false
        self.usePhotoButton.enabled = false
        self.processButton.enabled = false
        self.clearTextButton.enabled = false
        self.originalText.editable = false
        
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
        self.getCipherButton.enabled = true
        self.infoButton.enabled = true
        self.usePhotoButton.enabled = true
        self.processButton.enabled = true
        self.clearTextButton.enabled = true
        self.originalText.editable = true
        let origImage = UIImage(named: "info");
        let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        infoButton.setImage(tintedImage, forState: .Normal)
        infoButton.tintColor = UIColor.greenColor()
        infoButton.enabled = true
    }
    
    @IBAction func onGetCipherText(sender: AnyObject) {
        let origImage = UIImage(named: "info");
        let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        infoButton.setImage(tintedImage, forState: .Normal)
        infoButton.tintColor = UIColor.greenColor()
        infoButton.enabled = true
        
        let cipherType: String = cipherPickerTextField.text!
        switch cipherType {
        case cipherPickerOption[0]:
            quizModel.generateAffineCipher()
            break;
        case cipherPickerOption[1]:
            quizModel.generateMonoalphabetic()
            break;
        case cipherPickerOption[2]:
            quizModel.generateShiftLeftCipher()
            break;
        case cipherPickerOption[3]:
            quizModel.generateShiftRightCipher()
            break;
        case cipherPickerOption[4]:
            quizModel.generateTranspositionCipher()
            break;
        case cipherPickerOption[5]:
            quizModel.generatePlayfairCipher()
            break;
        case cipherPickerOption[6]:
            quizModel.generateVigenereCipher()
            break;
        case cipherPickerOption[7]:
            quizModel.generateBeaufortCipher()
            break;
        default:
            break
        }
        originalText.text = quizModel.getCipherText()
        key = quizModel.getKeyWord()
        globalOriginalText = originalText.text
        globalModifiedText = globalOriginalText
        dismissKeyboard()
    }
}


