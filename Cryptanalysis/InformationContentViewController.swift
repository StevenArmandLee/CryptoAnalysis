//
//  InformationContentViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 21/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation
import UIKit


class InformationContentViewController: UIViewController, UITextViewDelegate {
   
    @IBOutlet weak var informationiTextView: UITextView!
    var pageIndex: Int!
    var content: String!
    var monoOrPolyContent: String!
    var frequencyContent: String!
    
    @IBOutlet weak var monoOrPolyLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    
       override func viewDidLoad() {
        super.viewDidLoad()
        informationiTextView.delegate = self
        informationiTextView.layer.borderWidth=1
        informationiTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        self.informationiTextView.text = self.content
        self.frequencyLabel.text = self.frequencyContent
        self.monoOrPolyLabel.text = "0.065 = Monoalphabetic, 0.38 = Polyalphabetic.\n The IC is = " + monoOrPolyContent
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        
        //informationTextView.text = getStaticalInformation()
    }
    
    
}