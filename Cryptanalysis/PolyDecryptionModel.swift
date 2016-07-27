//
//  PolyDecryptionModel.swift
//  Cryptanalysis
//
//  Created by steven lee on 11/6/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class PolyDecryption {
    /***********************************************/
    /************** VIGENERE CIPHER ****************/
    /***********************************************/
    func vigenereEncryption(text: String, key: String) -> String {
        let plainText = text.uppercaseString
        let lengthOfPtext = plainText.characters.count
        let lengthOfKey = key.characters.count
        var ciphertext = String()
        var count = 0
        
        for i in 0..<lengthOfPtext {
            let indexOfPtext = plainText.startIndex.advancedBy(i)
            let ptextNum = alphabet_Translator[plainText[indexOfPtext]]!
            
            if ptextNum == -1 {
                ciphertext.append(plainText[indexOfPtext])
            }
            else{
                let indexOfKey = key.startIndex.advancedBy(count % lengthOfKey)
                let keyNum = alphabet_Translator[key[indexOfKey]]!
                var index = ptextNum + keyNum
                
                if index >= 26 {
                    index = index - 26
                }
                
                ciphertext.append(numeric_Translator[index]!)
                count += 1
            }
        }
        
        return ciphertext
    }
    
    
    
    
    /***********************************************/
    /************** BEAUFORT CIPHER ****************/
    /***********************************************/
    func beaufortEncryption(text: String, key: String) -> String {
        let plainText = text.uppercaseString
        let lengthOfPtext = plainText.characters.count
        let lengthOfKey = key.characters.count
        var ciphertext = String()
        var count = 0
        
        for i in 0..<lengthOfPtext {
            let indexOfPtext = plainText.startIndex.advancedBy(i)
            let ptextNum = alphabet_Translator[plainText[indexOfPtext]]!
            
            if ptextNum == -1 {
                ciphertext.append(plainText[indexOfPtext])
            }
            else{
                let indexOfKey = key.startIndex.advancedBy(count % lengthOfKey)
                let keyNum = alphabet_Translator[key[indexOfKey]]!
                var index = ptextNum - keyNum
                
                if index <= -1 {
                    index = index + 26
                }
                
                ciphertext.append(numeric_Translator[index]!)
                count += 1
            }
        }
        
        return ciphertext
    }
    
}