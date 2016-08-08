//
//  PlayfairToolViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 8/8/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import UIKit

class PlayfairToolViewController: UIViewController {

    private var playfairModel = PlayfairDecryptionModel()
    
    @IBOutlet weak var textField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = playfairModel.analyzePlayfair(globalModifiedText)
    }
    
    
}
