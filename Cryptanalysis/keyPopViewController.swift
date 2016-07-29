//
//  keyPopViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 29/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import UIKit

class keyPopViewController: UIViewController {

    var key = ""
    @IBOutlet weak var keyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        keyLabel.text = key
    }
    
}
