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
}