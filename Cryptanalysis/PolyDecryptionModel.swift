//
//  PolyDecryptionModel.swift
//  Cryptanalysis
//
//  Created by steven lee on 11/6/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class PolyDecryptionModel {
    /***********************************************/
    /************** VIGENERE CIPHER ****************/
    /***********************************************/
    func vigenereEncryption(text: String, key: String) -> String {
        let plainText = text.uppercaseString
        let lengthOfPtext = plainText.characters.count
        let lengthOfKey = key.characters.count
        var ciphertext = String()
        let upperKey = key.uppercaseString
        var count = 0
        
        for i in 0..<lengthOfPtext {
            let indexOfPtext = plainText.startIndex.advancedBy(i)
            
            if let ptextNum = alphabet_Translator[plainText[indexOfPtext]] {
                
                let indexOfKey = upperKey.startIndex.advancedBy(count % lengthOfKey)
                let keyNum = alphabet_Translator[upperKey[indexOfKey]]!
                var index = ptextNum + keyNum
                
                if index >= 26 {
                    index = index - 26
                }
                
                ciphertext.append(numeric_Translator[index]!)
                count += 1
            }
            else{
                 ciphertext.append(plainText[indexOfPtext])
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
        let upperKey = key.uppercaseString
        var ciphertext = String()
        var count = 0
        
        for i in 0..<lengthOfPtext {
            let indexOfPtext = plainText.startIndex.advancedBy(i)
            
            if let ptextNum = alphabet_Translator[plainText[indexOfPtext]] {
                
                let indexOfKey = upperKey.startIndex.advancedBy(count % lengthOfKey)
                let keyNum = alphabet_Translator[upperKey[indexOfKey]]!
                var index = ptextNum - keyNum
                
                if index <= -1 {
                    index = index + 26
                }
                
                ciphertext.append(numeric_Translator[index]!)
                count += 1
            }
            else{
                ciphertext.append(plainText[indexOfPtext])
            }
        }
        
        return ciphertext
    }
    
    
    /***********************************************/
    /************* DECRYPTION BUTTON ***************/
    /***********************************************/
    func decryptionButton (ctext : String, key : String, type : Int) -> String
    {
        
        let lengthOfCtext = ctext.characters.count
        let lengthOfKey = key.characters.count
        var ptext = String()
        var count = 0
        
        for i in 0..<lengthOfCtext {
            let indexOfCtext = ctext.startIndex.advancedBy(i)
            
            if let ctextNum = alphabet_Translator[ctext[indexOfCtext]] {
                let indexOfKey = key.startIndex.advancedBy(count % lengthOfKey)
                let keyNum = alphabet_Translator[key[indexOfKey]]!
                var index = 0
                
                if type == 0 {
                    index = ctextNum - keyNum
                }
                else {
                    index = ctextNum + keyNum
                }
                
                if index < 0 {
                    index = index + 26
                }
                else if index >= 26 {
                    index = index - 26
                }
                ptext.append(numeric_Translator[index]!)
                count += 1
            }
            else {
                ptext.append(ctext[indexOfCtext])
            }
        }
        
        return ptext
    }
    
    /***********************************************/
    /***************** CHECK KEY *******************/
    /***********************************************/
    func checkKey (key : String) -> Bool
    {
        if key == "" {
            return false
        }
        
        for charKey in key.characters {
            if (alphabet_Translator[charKey] == nil){
                return false
            }
        }
        
        return true
    }
    
    /***********************************************/
    /***************** AUTO POLY *******************/
    /***********************************************/
    func autoDecryptPoly(str :String) -> String{
        
        var trimmedText = str.stringByReplacingOccurrencesOfString(" ", withString: "").stringByReplacingOccurrencesOfString("\n", withString: "")
        trimmedText = trimmedText.uppercaseString
        let total = trimmedText.characters.count-1
        var key : [String]
        var fitnessScore : Int = 0
        let keyLength = 8
        var totalRow = (total+1) / keyLength
        let limit = totalRow * keyLength
        var bestBigram: String
        var bestFitnessScore :Int = 0
        for i in 0...keyLength-1{
            bestFitnessScore = 0
            bestBigram = ""
            for (bigram, value) in bigramEnglish{
                var fitScore = 0
                for j in 0..<totalRow{
                    let bigramTaken = trimmedText.substringWithRange(trimmedText.startIndex.advancedBy(i+(j*keyLength))...trimmedText.startIndex.advancedBy(i+(j*keyLength)+1))
                    
                    fitScore += getFitnessScore(bigramTaken, bigram: bigram)
                }
                if fitScore > bestFitnessScore{
                    bestFitnessScore = fitScore
                    bestBigram = bigram
                    
                }
            }
        }
        
        return String("BEST KEY")
    }
    
    func getFitnessScore(text: String, bigram: String)->Int{
        var textIndex = text.startIndex.advancedBy(0)
        var keyIndex = bigram.startIndex.advancedBy(0)
        print(text[textIndex])
        var result = String(getPlainText(text[textIndex], key: bigram[keyIndex]))
        textIndex = text.startIndex.advancedBy(1)
        keyIndex = bigram.startIndex.advancedBy(1)
        result += String(getPlainText(text[textIndex], key: bigram[keyIndex]))
        
        return bigramEnglish[result]!
        
    }
    func getPlainText(chr : Character, key : Character) -> Character{
        var charResult = alphabet_Translator[chr]! - alphabet_Translator[key]!
        if charResult < 0 {
            charResult+=26
        }
        return numeric_Translator[charResult]!
    }
}