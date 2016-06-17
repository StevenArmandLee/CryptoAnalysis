//
//  SecondViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 11/5/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import UIKit
import Charts

class StatisticalViewController: UIViewController {

    
    @IBOutlet weak var graphViewContainer: UIView!
    @IBOutlet weak var informationViewController: UIView!
    
   
    @IBOutlet weak var segmentedControl: UISegmentedControl!
   
    override func viewDidLoad() {
        graphViewContainer.hidden=false
        informationViewController.hidden=true
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        
        
        //informationTextView.text = getStaticalInformation()
    }
    
    
    @IBAction func changeSegment(sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            print("test")
            graphViewContainer.hidden=false
            informationViewController.hidden=true
            
        case 1:
            graphViewContainer.hidden=true
            informationViewController.hidden=false
        default:
            break;
        }
    }
    

}

