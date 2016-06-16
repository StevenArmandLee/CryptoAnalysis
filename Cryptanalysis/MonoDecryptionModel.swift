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
            let userKeyIndex = userKey.startIndex.advancedBy(i)
            let userValueIndex = userValue.startIndex.advancedBy(i)
            dictionary[userKey.substringWithRange(userKeyIndex...userKeyIndex)] = userValue.substringWithRange(userValueIndex...userValueIndex)
        }
    }
    
    func applyReplaceUsingDictionary(globalText :String)->String
    {
        print(globalText)
        var newGlobalText = ""
        for index in 0..<globalText.characters.count{
            let globalTextIndex = globalText.startIndex.advancedBy(index)
            newGlobalText += dictionary[globalText.substringWithRange(globalTextIndex...globalTextIndex)]!
        }
        return newGlobalText
    }
    
}