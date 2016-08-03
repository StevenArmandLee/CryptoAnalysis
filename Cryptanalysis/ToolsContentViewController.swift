//
//  ToolsContentViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 28/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//



class ToolsContentViewController: UIViewController {
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
        initiView()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ToolsContentViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func onCompute(sender: UIButton) {
        compute()
        dismissKeyboard()
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
        outputTextView.text = calculatorModel.fastExpo(Int(firstInput.text!)!, modulus: Int(secondInput.text!)!, exponent: Int(toThePowerInput.text!)!)
    }
    
    func inverseMod() {
        outputTextView.text = calculatorModel.gcdR( Int(firstInput.text!)!, divisor: Int(secondInput.text!)!)
    }
    
    func IC() {
        outputTextView.text = stasticalModel.getAvgIC(globalOriginalText, period: Int(secondInput.text!)!)
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
    
    
}
