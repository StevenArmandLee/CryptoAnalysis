//
//  ToolsViewController.swift
//  Cryptanalysis
//
//  Created by steven lee on 28/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//



class ToolsViewController: UIViewController {
    @IBOutlet weak var outputTextView: UITextView!
    var resultText = ""
    var isTextChange = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeText()
    }
    
    func showResult() {
        outputTextView.text = resultText
    }
    
    func changeText(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            while(true)
            {
                print(self.isTextChange)
                if(self.isTextChange)
                {
                    print(self.resultText)
                    self.outputTextView.text = self.resultText
                    self.isTextChange = false
                }
            }
            dispatch_async(dispatch_get_main_queue()){
                [weak self] in
                
            }

        }

    }
}