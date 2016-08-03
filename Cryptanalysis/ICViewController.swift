//
//  ICViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 23/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation
import UIKit
import Charts

class ICViewController: UIViewController, UITextFieldDelegate {
    
    //TODO IF THE INDEX AND PERIOD ARE 0
   
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var indexField: UITextField!
    @IBOutlet weak var periodField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var stasticalModel: StasticalModel = StasticalModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.indexField.delegate = self
        self.periodField.delegate = self
        registerForKeyboardNotifications()
        
        chartView.descriptionText = ""
        chartView.doubleTapToZoomEnabled = false
        chartView.leftAxis.valueFormatter = NSNumberFormatter()
        chartView.leftAxis.valueFormatter?.minimumFractionDigits = 0
        chartView.rightAxis.valueFormatter = NSNumberFormatter()
        chartView.rightAxis.valueFormatter?.minimumFractionDigits = 0
        chartView.animate(xAxisDuration: 2, yAxisDuration: 2)
        setCharts(stasticalModel.getPolyGraphXLabel(), values: stasticalModel.getPolyXAxisData())
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ICViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification)
    {
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.scrollEnabled = true
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeFieldPresent = indexField
        {
            if (!CGRectContainsPoint(aRect, indexField!.frame.origin))
            {
                self.scrollView.scrollRectToVisible(indexField!.frame, animated: true)
            }
        }
         else if let activeFieldPresent = periodField
        {
            if (!CGRectContainsPoint(aRect, periodField!.frame.origin))
            {
                self.scrollView.scrollRectToVisible(periodField!.frame, animated: true)
            }
        }
        
        
    }
    
    func keyboardWillBeHidden(notification: NSNotification)
    {
        //Once keyboard disappears, restore original positions
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.scrollEnabled = false
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        scrollView.setContentOffset(CGPointMake(0, 250), animated: true)
    }
    
    
    
    //Graph Functions
    func setCharts(xAxisLabels: [String], values: [Double])
    {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<xAxisLabels.count
        {
            dataEntries.append(BarChartDataEntry(value: values[i], xIndex: i))
            
        }
        let charDataSet = BarChartDataSet(yVals: dataEntries, label: "Character Frequency")
        charDataSet.valueFormatter?.minimumFractionDigits = 0
        charDataSet.valueFormatter?.generatesDecimalNumbers=false
        let charData = BarChartData(xVals: xAxisLabels, dataSet: charDataSet)
        chartView.data=charData
    }

    @IBAction func onGenerateGraph(sender: AnyObject) {
    
        
            view.endEditing(true)
        if (indexField.text != "") && (periodField.text != "") {
            var index = Int(indexField.text!)!
            var period = Int(periodField.text!)!
            
            if(index == 0) && (period == 0)
            {
                index = 1
                period = 1
            }
            
            if(index <= period) {
                chartView.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
                stasticalModel.generatePolyGraph(index, period: period)
                setCharts(stasticalModel.getPolyGraphXLabel(), values: stasticalModel.getPolyXAxisData())
            }
            else {
                let attributedString = NSAttributedString(string: "Alert", attributes: [
                    NSFontAttributeName : UIFont.systemFontOfSize(20),
                    NSForegroundColorAttributeName : UIColor.redColor()
                    ])
                let alert = UIAlertController(title: "", message: "Invalid inputs",  preferredStyle: .Alert)
                
                alert.setValue(attributedString, forKey: "attributedTitle")
                alert.addAction(UIAlertAction(title:"Close",style: UIAlertActionStyle.Default, handler:nil))
                presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,replacementString string: String) -> Bool {
        
        // Create an `NSCharacterSet` set which includes everything *but* the digits
        let inverseSet = NSCharacterSet(charactersInString:"0123456789").invertedSet
        
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
}
