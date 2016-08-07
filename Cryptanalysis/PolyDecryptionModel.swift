//
//  PolyDecryptionModel.swift
//  Cryptanalysis
//
//  Created by steven lee on 11/6/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class PolyDecryptionModel {
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
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
    func autoDecryptPoly(str :String, isBeaufort: Bool) -> String{
        var stasticalModel: StasticalModel = StasticalModel()
        var trimmedText = removeSpecialCharsFromString(str)
        if trimmedText.characters.count > 120{
            trimmedText = trimmedText.substringToIndex(str.startIndex.advancedBy(120))
        }
        trimmedText = trimmedText.stringByReplacingOccurrencesOfString(" ", withString: "").stringByReplacingOccurrencesOfString("\n", withString: "")
        trimmedText = trimmedText.uppercaseString
        let total = trimmedText.characters.count-1
        let keyLength = stasticalModel.estimatedKeyLength(globalOriginalText)
        if keyLength == 0 {
            return "No Key Found!!"
        }
        let totalRow = (total+1) / keyLength
        var bestBigram: String
        var bestFitnessScore :UInt64 = 0
        
        var bestBigramArray : [String] = [String]()
        var bestFitnessScoreArray :[UInt64] = [UInt64]()
        for i in 0...keyLength-1{
            bestFitnessScore = 0
            bestBigram = ""
            for (bigram, _) in bigramEnglish{
                var fitScore: UInt64 = 0
                for j in 0..<totalRow{
                    var bigramTaken :String
                    if i == keyLength-1{
                        bigramTaken = trimmedText.substringWithRange(trimmedText.startIndex.advancedBy(i+(j*keyLength))...trimmedText.startIndex.advancedBy(i+(j*keyLength)))+trimmedText.substringWithRange(trimmedText.startIndex.advancedBy(j*keyLength)...trimmedText.startIndex.advancedBy(j*keyLength))
                    }else{
                        bigramTaken = trimmedText.substringWithRange(trimmedText.startIndex.advancedBy(i+(j*keyLength))...trimmedText.startIndex.advancedBy(i+(j*keyLength)+1))
                    }
                    fitScore += UInt64(getFitnessScore(bigramTaken, bigram: bigram, isBeaufort: isBeaufort))
                }
                if fitScore > bestFitnessScore{
                    bestFitnessScore = fitScore
                    bestBigram = bigram
                    
                }
            }
            bestBigramArray.append(bestBigram)
            bestFitnessScoreArray.append(bestFitnessScore)
        }
        let key = findKeyPoly(bestBigramArray, fsArray: bestFitnessScoreArray, keyLength:keyLength)
        return key
    }
    
    func findKeyPoly(bArray: [String], fsArray:[UInt64], keyLength:Int)->String{
        var stringResult = ""
        for i in 0...keyLength-1{
            if i == 0{
                if fsArray[0] > fsArray[keyLength-1]{
                    stringResult += String(bArray[0][bArray[0].startIndex.advancedBy(0)])
                }
                else{
                    stringResult += String(bArray[keyLength-1][bArray[keyLength-1].startIndex.advancedBy(1)])
                }
            }else{
                if fsArray[i] > fsArray[i-1]{
                    stringResult += String(bArray[i][bArray[i].startIndex.advancedBy(0)])
                }else{
                    stringResult += String(bArray[i-1][bArray[i-1].startIndex.advancedBy(1)])
                }
            }
        }
        
        return stringResult
    }
    func getFitnessScore(text: String, bigram: String, isBeaufort: Bool)->UInt64{
        var textIndex = text.startIndex.advancedBy(0)
        var keyIndex = bigram.startIndex.advancedBy(0)
        var result = String(getPlainText(text[textIndex], key: bigram[keyIndex], isBeaufort: isBeaufort))
        textIndex = text.startIndex.advancedBy(1)
        keyIndex = bigram.startIndex.advancedBy(1)
        result += String(getPlainText(text[textIndex], key: bigram[keyIndex], isBeaufort: isBeaufort))
        
        return UInt64(bigramEnglish[result]!)
        
    }
    func getPlainText(chr : Character, key : Character, isBeaufort: Bool) -> Character{
        var charResult : Int
        if isBeaufort {
            charResult = alphabet_Translator[chr]! + alphabet_Translator[key]!
        }
        else {
            charResult = alphabet_Translator[chr]! - alphabet_Translator[key]!
        }
        if charResult < 0 {
            charResult+=26
        }else if charResult > 25{
            charResult-=26
        }
        return numeric_Translator[charResult]!
    }
    
    
}