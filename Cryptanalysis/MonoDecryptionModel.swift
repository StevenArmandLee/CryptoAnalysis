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
    /* //
    var dictionary : [String:String] = [:]
    func insertKeyToDictionary(userKey :String, userValue :String){
        if dictionary.isEmpty{
            print("a")
            dictionary[userKey] = userValue
        }else{
            for (key, _) in dictionary{
                if userKey == key{
                    print("b")
                    dictionary[userKey] = userValue
                    break
                }else{
                    if key.rangeOfString(userKey) != nil{
                        print("c")
                        break
                    }
                }
            }
        }
    }
    
    func applyReplaceUsingDictionary(globalText :String)->String
    {
        var mutableGlobalText = globalText
        for (key, value) in dictionary {
            mutableGlobalText = mutableGlobalText.stringByReplacingOccurrencesOfString(key, withString: value)
        }
        return mutableGlobalText
    }
    */
    //Version 2
    var dictionary : [String:String] = [:]
    
    init(){
        dictionary = [
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
    
    func insertKeyToDictionary(userKey :String, userValue :String){
        let iterationValue = min(userKey.characters.count, userValue.characters.count)
        
        for i in 0..<iterationValue{
            let userKeyLetter = userKey.substringWithRange(userKey.startIndex.advancedBy(i)...userKey.startIndex.advancedBy(i))
            let userValueLetter = userValue.substringWithRange(userValue.startIndex.advancedBy(i)...userValue.startIndex.advancedBy(i))
            dictionary[userKeyLetter] = userValueLetter
        }
    }
    
    func applyReplaceUsingDictionary(globalText :String)->String{
        var newGlobalText = ""
        for index in 0..<globalText.characters.count{
            let globalTextIndex = globalText.startIndex.advancedBy(index)
            let letterInGlobalText = globalText.substringWithRange(globalTextIndex...globalTextIndex)
            if let dictionaryLetter = dictionary[letterInGlobalText]{
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