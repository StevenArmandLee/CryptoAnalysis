//
//  MonoDecryptionModel.swift
//  Cryptanalysis
//
//  Created by steven lee on 11/6/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class MonoDecryption
{
    
    var dictionaryBlock : [String:String] = [:]
    var dictionaryStream : [String:String] = [:]
    var alphabet_Translator: [Character:Int] =
        ["A" : 0, "B" : 1, "C" : 2, "D" : 3, "E" : 4, "F" : 5, "G" : 6, "H" : 7, "I" : 8, "J" : 9, "K" : 10, "L" : 11, "M" : 12, "N" : 13, "O" : 14, "P" : 15, "Q" : 16, "R" : 17, "S" : 18, "T" : 19, "U" : 20, "V" : 21, "W" : 22, "X" : 23, "Y" : 24, "Z" : 25]
    var numeric_Translator: [Int:Character] =  [0 : "A", 1 : "B", 2 : "C", 3 : "D", 4 : "E", 5 : "F", 6 : "G", 7 : "H", 8 : "I", 9 : "J", 10 : "K", 11 : "L", 12 : "M", 13 : "N", 14 : "O", 15 : "P", 16 : "Q", 17 : "R", 18 : "S", 19 : "T", 20 : "U", 21 : "V", 22 : "W", 23 : "X", 24 : "Y", 25 : "Z"]
    init(){
        dictionaryStream = [
            "a" : "a", "k" : "k", "u" : "u",
            "b" : "b", "l" : "l", "v" : "v",
            "c" : "c", "m" : "m", "w" : "w",
            "d" : "d", "n" : "n", "x" : "x",
            "e" : "e", "o" : "o", "y" : "y",
            "f" : "f", "p" : "p", "z" : "z",
            "g" : "g", "q" : "q",
            "h" : "h", "r" : "r",
            "i" : "i", "s" : "s",
            "j" : "j", "t" : "t",
        ]
    }
    
    func insertKeyToDictionaryBlock(userKey :String, userValue :String){
        if dictionaryBlock.isEmpty{
            dictionaryBlock[userKey] = userValue
        }else{
            for (key, _) in dictionaryBlock{
                if userKey == key{
                    dictionaryBlock[userKey] = userValue
                    break
                }else{
                    if key.rangeOfString(userKey) != nil{
                        break
                    }
                }
            }
        }
    }
    
    func applyReplaceUsingDictionaryBlock(globalText :String)->String
    {
        var mutableGlobalText = globalText
        for (key, value) in dictionaryBlock{
            mutableGlobalText = mutableGlobalText.stringByReplacingOccurrencesOfString(key, withString: value)
        }
        return mutableGlobalText
    }
    
    func insertKeyToDictionaryStream(userKey :String, userValue :String){
        let iterationValue = min(userKey.characters.count, userValue.characters.count)
        
        for i in 0..<iterationValue{
            let userKeyLetter = userKey.substringWithRange(userKey.startIndex.advancedBy(i)...userKey.startIndex.advancedBy(i))
            let userValueLetter = userValue.substringWithRange(userValue.startIndex.advancedBy(i)...userValue.startIndex.advancedBy(i))
            dictionaryStream[userKeyLetter] = userValueLetter
        }
    }
    
    func applyReplaceUsingDictionaryStream(globalText :String)->String{
        var newGlobalText = ""
        for index in 0..<globalText.characters.count{
            let globalTextIndex = globalText.startIndex.advancedBy(index)
            let letterInGlobalText = globalText.substringWithRange(globalTextIndex...globalTextIndex)
            if let dictionaryLetter = dictionaryStream[letterInGlobalText]{
                newGlobalText += dictionaryLetter
            }
            else{
                newGlobalText += letterInGlobalText
            }
        }
        return newGlobalText
    }
    
    func removeDuplicateLetterFromString(string :String)->String{
        var stringResult = ""
        for char in string.characters{
            if (stringResult.rangeOfString(String(char))) == nil{
                stringResult += String(char)
            }
        }
        return stringResult
    }
    
    func autoFillKeyString(keyString :String)->String{
        var tempKeyString = keyString.lowercaseString
        for char in "abcdefghijklmnopqrstuvwxyz".characters{
            if (tempKeyString.rangeOfString(String(char)) == nil){
                tempKeyString+=String(char)
            }
        }
        return tempKeyString
    }
    
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
            //all_steps += "\n" + a1 + " " + a1 + " " a1 + " " a1 + " " a1 + " " a1 + " "; a1
        }
        if n1 != 1 {
            return -1
        }else{
            return (divisor+b2)
        }
    }
    func applyAffineEncryptionUsingKey(globalText :String, alphaKey : Int, betaKey :Int)->String{
        var stringResult = ""
        for char in globalText.characters{
            if char != " "{
                let charInNumberForm = alphabet_Translator[char]
                var afterEncryptionNumber = alphaKey*(charInNumberForm)! + betaKey
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
    
    func applyAffineDecryptionUsingKey(globalText : String, alphaKey :Int, betaKey :Int)->String{
        var stringResult = ""
        for char in globalText.characters{
            if char != " "{
                let charInNumberForm = alphabet_Translator[char]
                let newAlphaKey = gcdR(Int(alphaKey), divisor:26)
                var afterEncryptionNumber = ((charInNumberForm)! - betaKey)*newAlphaKey
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
}