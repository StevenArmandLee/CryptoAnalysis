//
//  ShiftDecryptionModel.swift
//  Cryptanalysis
//
//  Created by Joshua Saputra on 27/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class ShiftDecryption{
    /***********************************************/
    /************* SHIFT LEFT CIPHER ***************/
    /***********************************************/
    func shiftLeftEncryption(text: String, key: String) -> String {
        let plainText = text.uppercaseString
        let lengthOfPtext = plainText.characters.count
        var ciphertext = String()
        
        for i in 0..<lengthOfPtext {
            let indexOfPtext = plainText.startIndex.advancedBy(i)
            
            let ptextNum = alphabet_Translator[plainText[indexOfPtext]]!
            
            if ptextNum == -1 {
                ciphertext.append(plainText[indexOfPtext])
            }
            else{
                
                let keyNum = Int(key)
                
                var index = ptextNum + keyNum!
                
                if index >= 26 {
                    index = index - 26
                }
                ciphertext.append(numeric_Translator[index]!)
            }
        }
        
        return ciphertext
    }
    
    /***********************************************/
    /************* SHIFT RIGHT CIPHER **************/
    /***********************************************/
    func shiftRightEncryption(text: String, key: String) -> String {
        let plainText = text.uppercaseString
        let lengthOfPtext = plainText.characters.count
        var ciphertext = String()
        
        for i in 0..<lengthOfPtext {
            let indexOfPtext = plainText.startIndex.advancedBy(i)
            
            let ptextNum = alphabet_Translator[text[indexOfPtext]]!
            
            if ptextNum == -1 {
                ciphertext.append(plainText[indexOfPtext])
            }
            else{
                
                let keyNum = Int(key)!
                
                var index = ptextNum - keyNum
                
                if index <= -1 {
                    index = index + 26
                }
                ciphertext.append(numeric_Translator[index]!)
            }
        }
        
        return ciphertext
    }
}
