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
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InputViewController.dismissKeyboard))
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
        var info : NSDictionary = notification.userInfo!
        var keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        var contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
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
        var info : NSDictionary = notification.userInfo!
        var keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        var contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.scrollEnabled = false
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField!)
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
                //TODO make alert
            }
        }
        
       
    }
}
