//
//  MonoDecryptionModel.swift
//  Cryptanalysis
//
//  Created by steven lee on 11/6/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

var alphabet_Translator: [Character:Int] =
    ["A" : 0, "B" : 1, "C" : 2, "D" : 3, "E" : 4, "F" : 5, "G" : 6, "H" : 7, "I" : 8, "J" : 9, "K" : 10, "L" : 11, "M" : 12, "N" : 13, "O" : 14, "P" : 15, "Q" : 16, "R" : 17, "S" : 18, "T" : 19, "U" : 20, "V" : 21, "W" : 22, "X" : 23, "Y" : 24, "Z" : 25,"a" : 0, "b" : 1, "c" : 2, "d" : 3, "e" : 4, "f" : 5, "g" : 6, "h" : 7, "i" : 8, "j" : 9, "k" : 10, "l" : 11, "m" : 12, "n" : 13, "o" : 14, "p" : 15, "q" : 16, "r" : 17, "s" : 18, "t" : 19, "u" : 20, "v" : 21, "w" : 22, "x" : 23, "y" : 24, "z" : 25]
var numeric_Translator: [Int:Character] =  [0 : "A", 1 : "B", 2 : "C", 3 : "D", 4 : "E", 5 : "F", 6 : "G", 7 : "H", 8 : "I", 9 : "J", 10 : "K", 11 : "L", 12 : "M", 13 : "N", 14 : "O", 15 : "P", 16 : "Q", 17 : "R", 18 : "S", 19 : "T", 20 : "U", 21 : "V", 22 : "W", 23 : "X", 24 : "Y", 25 : "Z"]

class MonoDecryptionModel
{
    
    var dictionaryBlock : [String:String] = [:]
    var dictionaryStream : [String:String] = [:]
    
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
    
    //MonoAlphabetic Cipher
    //---------------------------------------------------------------------------------
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
                    }else{
                        dictionaryBlock[userKey] = userValue
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
    
    func resetDictionary(){
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
    //---------------------------------------------------------------------------------
    
    
}