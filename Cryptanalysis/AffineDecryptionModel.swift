//
//  AffineDecryptionModel.swift
//  Cryptanalysis
//
//  Created by Joshua Saputra on 27/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class AffineDecryptionModel{
    private var autoAlphaKey = Int()
    private var autoBetaKey = Int()
    
    func getAlphaKey() -> Int {
        return autoAlphaKey
    }
    
    func getBetaKey() -> Int {
        return autoBetaKey
    }
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }

    //Affine Cipher
    //---------------------------------------------------------------------------------
    func gcdR(dividend: Int, divisor: Int) -> Int{
        //assign n1 & n2
        var (n1, n2) = (divisor, dividend)
        //var all_steps
        if  divisor < dividend{
            (n1, n2) = (dividend, divisor)
        }
        var (a1, b1, a2, b2) = (1, 0, 0, 1)
        while n2 != 0 {
            
            let quotient = n1 / n2
            //n1%n2 is the reminder
            (n1, n2) = (n2, n1 % n2)
            if n2 == 0 {
                break;
            }
            (a1, b1, a2, b2) = (a2, b2, a1 - quotient * a2, b1 - quotient * b2)
            
        }
        if n1 != 1 {
            return -1
        }else{
            return (divisor+b2)
        }
    }
    func applyAffineEncryptionUsingKey(globalText :String, alphaKey : Int, betaKey :Int)->String{
        var stringResult = ""
        for char in globalText.uppercaseString.characters{
            if let charAfterCheck = alphabet_Translator[char]{
                let charInNumberForm = charAfterCheck
                var afterEncryptionNumber = alphaKey*charInNumberForm + betaKey
                afterEncryptionNumber %= 26
                if(afterEncryptionNumber < 0){
                    afterEncryptionNumber += 26
                }
                stringResult += String(numeric_Translator[afterEncryptionNumber]!)
            }
            else{
                stringResult += String(char)
            }
        }
        return stringResult
    }
    
    func applyAffineDecryptionUsingKey(globalText :	 String, alphaKey :Int, betaKey :Int)->String{
        var stringResult = ""
        for char in globalText.uppercaseString.characters{
            if let charAfterCheck = alphabet_Translator[char]{
                let charInNumberForm = charAfterCheck
                let newAlphaKey = gcdR(Int(alphaKey), divisor:26)
                var afterEncryptionNumber = ((charInNumberForm) - betaKey)*newAlphaKey
                afterEncryptionNumber %= 26
                if(afterEncryptionNumber < 0){
                    afterEncryptionNumber += 26
                }
                stringResult += String(numeric_Translator[afterEncryptionNumber]!)
            }
            else{
                stringResult += String(char)
            }
        }
        return stringResult
    }
    
    //////////////////////////////////////////
    //////// AFFINE AUTO /////////////////////
    //////////////////////////////////////////
    func autoDecryptAffine(str :String) -> String {
        var trimmedText = removeSpecialCharsFromString(str)
        trimmedText = trimmedText.stringByReplacingOccurrencesOfString(" ", withString: "").stringByReplacingOccurrencesOfString("\n", withString: "")
        trimmedText = trimmedText.lowercaseString
        let arrayOfInt : [Int] = [1,3,5,7,9,11,15,17,19,21,23,25]
        var bestFitnessScore = 0
        var bestAlphaKey = -1
        var bestBetaKey = -1
        var bestResult = ""
        for alphaKey in arrayOfInt{
            for betaKey in 0...25{
                var fitScore = 0
                let stringResult = applyAffineDecryptionUsingKey(trimmedText, alphaKey: alphaKey, betaKey: betaKey).stringByReplacingOccurrencesOfString(" ", withString: "")
                
                for i in 0..<stringResult.characters.count-1{
                    let bigramInText = stringResult.substringWithRange(stringResult.startIndex.advancedBy(i)..<stringResult.startIndex.advancedBy(i+2))
                    fitScore += bigramEnglish[bigramInText]!
                }
                if fitScore > bestFitnessScore{
                    bestResult = stringResult
                    bestFitnessScore = fitScore
                    bestAlphaKey = alphaKey
                    bestBetaKey = betaKey
                }
            }
        }
        
        autoAlphaKey = bestAlphaKey
        autoBetaKey = bestBetaKey
        let result = String(bestAlphaKey) + "and" + String(bestBetaKey)
        
        return result
    }
}