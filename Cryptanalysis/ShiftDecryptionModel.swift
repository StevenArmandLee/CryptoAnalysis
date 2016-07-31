//
//  ShiftDecryptionModel.swift
//  Cryptanalysis
//
//  Created by Joshua Saputra on 27/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class ShiftDecryptionModel{
    
    private var currentOffset = Int()
    let numeric = "0123456789"
    
    func ShiftDecryptionModel(){
        currentOffset = 0
    }
    
    func getCurrentOffset() -> Int {
        return currentOffset
    }
    
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
                    index -= 26
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
                    index += 26
                }
                ciphertext.append(numeric_Translator[index]!)
            }else{
                ciphertext.append(plainText[indexOfPtext])
            }
        }
        
        return ciphertext
    }
    
    
    /***********************************************/
    /************* DECRYPTION BUTTON ***************/
    /***********************************************/
    func decryptionButton (ctext : String, offset : String, type : String) -> String {
        
        var intOffset = Int(offset)!
        
        if type == "Left" {
            currentOffset -= intOffset
        }
        else{
            currentOffset += intOffset
        }
        
        if currentOffset >= 26 || currentOffset <= -26{
            currentOffset = 0
            return ctext
        }
        
        if currentOffset <= -1 {
            intOffset = currentOffset + 26
        }
        else {
            intOffset = currentOffset
        }
        
        let lengthOfCtext = ctext.characters.count
        var ptext = String()
        
        for i in 0..<lengthOfCtext {
            let indexOfCtext = ctext.startIndex.advancedBy(i)
            
            if let ctextNum = alphabet_Translator[ctext[indexOfCtext]] {
                var index = 0
                
                index = ctextNum + intOffset
                
                if index <= -1 {
                    index += 26
                }
                else if index >= 26 {
                    index -= 26
                }
                ptext.append(numeric_Translator[index]!)

            }
            else{
                ptext.append(ctext[indexOfCtext])
            }
        }
        
        return ptext
    }
    
    func checkKey (offset : String) -> Bool {
        
        if offset == "" {
            return false
        }
        
        if currentOffset >= 26 || currentOffset <= -26 {
            return false
        }
        
        for charKey in offset.characters {
            if numeric.characters.contains(charKey) == false {
                return false
            }
        }
        
        return true
    }
    
    func autoDecryptShift(str :String) -> String {
        var bestFitnessScore = 0
        var bestShiftKey = -1
        for shiftKey in 0...25{
            var fitScore = 0
            let stringResult = decryptionButton(str, offset: String(shiftKey), type: "Right").stringByReplacingOccurrencesOfString(" ", withString: "")
            
            for i in 0..<stringResult.characters.count-1{
                let bigramInText = stringResult.substringWithRange(stringResult.startIndex.advancedBy(i)..<stringResult.startIndex.advancedBy(i+2))
                fitScore += bigramEnglish[bigramInText]!
            }
            if fitScore > bestFitnessScore{
                bestFitnessScore = fitScore
                bestShiftKey = shiftKey
            }
        }
        return String(bestShiftKey)
    }
}
