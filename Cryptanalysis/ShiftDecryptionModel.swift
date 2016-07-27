//
//  ShiftDecryptionModel.swift
//  Cryptanalysis
//
//  Created by Joshua Saputra on 27/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class ShiftDecryptionModel{
    /***********************************************/
    /************* SHIFT LEFT CIPHER ***************/
    /***********************************************/
    func shiftLeftEncryption(text: String, key: String) -> String {
        let plainText = text.uppercaseString
        let lengthOfPtext = plainText.characters.count
        var ciphertext = String()
        
        for i in 0..<lengthOfPtext {
            let indexOfPtext = plainText.startIndex.advancedBy(i)
            
            if let ptextNum = alphabet_Translator[plainText[indexOfPtext]]{
                let keyNum = Int(key)!
                
                var index = ptextNum + keyNum
                
                if index >= 26 {
                    index = index - 26
                }
                ciphertext.append(numeric_Translator[index]!)
            }else{
                ciphertext.append(plainText[indexOfPtext])
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
            
            if let ptextNum = alphabet_Translator[plainText[indexOfPtext]]{
                let keyNum = Int(key)!
                
                var index = ptextNum - keyNum
                
                if index <= -1 {
                    index = index + 26
                }
                ciphertext.append(numeric_Translator[index]!)
            }else{
                ciphertext.append(plainText[indexOfPtext])
            }
        }
        
        return ciphertext
    }
}
