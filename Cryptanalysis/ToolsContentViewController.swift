//
//  ToolsContentViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 28/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//



class ToolsContentViewController: UIViewController, UITextFieldDelegate {
    var receivedText = ""
    
    
    @IBOutlet weak var gcdLabel: UILabel!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var modLabel: UILabel!
    @IBOutlet weak var toThePowerInput: UITextField!
    @IBOutlet weak var firstInput: UITextField!
    @IBOutlet weak var secondInput: UITextField!
    
    var calculatorModel: CalculatorModel = CalculatorModel()
    var stasticalModel: StasticalModel = StasticalModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toThePowerInput.delegate = self
        firstInput.delegate = self
        secondInput.delegate = self
        initiView()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ToolsContentViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        outputTextView.setContentOffset(CGPointZero, animated: true)
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,replacementString string: String) -> Bool {
        
        toThePowerInput.resizeText()
        firstInput.resizeText()
        secondInput.resizeText()
        // Create an `NSCharacterSet` set which includes everything *but* the digits
        let inverseSet = NSCharacterSet(charactersInString:"-0123456789").invertedSet
        
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
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func onCompute(sender: UIButton) {
        compute()
        dismissKeyboard()
        outputTextView.setContentOffset(CGPointZero, animated: true)
            }
    
    func hideFastExpo() {
        toThePowerInput.hidden = true
        modLabel.hidden = true
        
    }
    func hideGCD() {
        gcdLabel.hidden=true
    }
    func showIC(){
        hideFastExpo()
        hideGCD()
        firstInput.hidden = true
        secondInput.placeholder = "Period"
    }
    func showInverseMod() {
        toThePowerInput.userInteractionEnabled = false
        toThePowerInput.text = "-1"
    }
    
    func initiView() {
        if receivedText == "Fast Exponential" {
            hideGCD()
        }
        else if receivedText == "GCD" {
            hideFastExpo()
            
        }
        else if receivedText == "Inverse Mod" {
            hideGCD()
            showInverseMod()
            
        }
        else if receivedText == "IC" {
            hideGCD()
            hideFastExpo()
            showIC()
        }
    }
    
    func computeGCD() {
        outputTextView.text = calculatorModel.gcd( Int(firstInput.text!)!, number_2: Int(secondInput.text!)!)
    }
    
    func fastExpo() {
        
            if Int(firstInput.text!) == nil || Int(secondInput.text!) == nil || Int(toThePowerInput.text!) == nil {
                showAlert()
            }
            else {
                outputTextView.text = calculatorModel.fastExpo(Int(firstInput.text!)!, modulus: Int(secondInput.text!)!, exponent: Int(toThePowerInput.text!)!)
        }
            
       
        
    }
    
    func inverseMod() {
        if Int(firstInput.text!) == nil || Int(secondInput.text!) == nil  {
            showAlert()
        }
        else {
            outputTextView.text = calculatorModel.gcdR( Int(firstInput.text!)!, divisor: Int(secondInput.text!)!)
        }
    }
    
    func IC() {
        if Int(firstInput.text!) == nil || Int(secondInput.text!) == nil  {
            showAlert()
        }
        else {
            outputTextView.text = stasticalModel.getAvgIC(globalOriginalText, period: Int(secondInput.text!)!)
        }
    }
    
    func compute() {
        if receivedText == "Fast Exponential" && firstInput.text! != "" && secondInput.text! != "" && toThePowerInput.text! != "" {
            fastExpo()
        }
        else if receivedText == "GCD" && firstInput.text! != "" && secondInput.text! != "" {
            computeGCD()
            
        }
        else if receivedText == "Inverse Mod" && firstInput.text! != "" && secondInput.text! != "" {
            inverseMod()
            
        }
        else if receivedText == "IC" && secondInput.text! != "" {
            IC()
        }

    }
    
    func showAlert() {
        let attributedString = NSAttributedString(string: "Alert", attributes: [
            NSFontAttributeName : UIFont.systemFontOfSize(20),
            NSForegroundColorAttributeName : UIColor.redColor()
            ])
        let alert = UIAlertController(title: "", message: "The number is invalid",  preferredStyle: .Alert)
        
        alert.setValue(attributedString, forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title:"Close",style: UIAlertActionStyle.Default, handler:nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
}
