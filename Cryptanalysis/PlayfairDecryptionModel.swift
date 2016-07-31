//
//  PlayfairDecryptionModel.swift
//  Cryptanalysis
//
//  Created by Joshua Saputra on 27/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

let alphabet = "abcdefghijklmnopqrstuvwxyz"

class PlayfairDecryptionModel{
    /***********************************************/
    /************** PLAYFAIR CIPHER ****************/
    /***********************************************/
    func playFairEncryption(text: String, key: String) -> String {
        var ciphertext = String()
        
        let keyTable = prepareKey(key.lowercaseString)
        
        let tempText = checkRepetition(text.lowercaseString)
        
        let plaintext = groupingTheText(tempText)
        
        for i in 0...plaintext.count-1 {
            ciphertext += getEncryptionValue(plaintext[i], keyTable: keyTable)
        }
        
        return ciphertext.uppercaseString
    }
    
    func prepareKey(key: String) -> [[String]] {
        var keyTable = [[String]](count: 5, repeatedValue: [String](count: 5, repeatedValue: ""))
        
        var autoFillKey = autoFillKeyString(key)
        autoFillKey = removeJLetter(autoFillKey)
        var index = 0
        for i in 0...4 {
            for j in 0...4 {
                let pChar = autoFillKey.startIndex.advancedBy(index)
                keyTable[i][j].append(autoFillKey[pChar])
                index += 1
            }
        }
        
        return keyTable
    }
    
    func autoFillKeyString(keyString: String) -> String{
        var tempKeyString = keyString.lowercaseString
        
        for char in alphabet.characters{
            if (tempKeyString.rangeOfString(String(char)) == nil){
                tempKeyString+=String(char)
            }
        }
        
        return tempKeyString
    }
    
    func removeJLetter (text: String) -> String {
        let tempText = text.stringByReplacingOccurrencesOfString("j", withString: "")
        return tempText
    }
    
    func checkRepetition(text: String) -> String {
        // prepare the plaintext, by removing any symbol
        // and also replace letter j with i
        var tempText = removeSpecialCharsFromString(replaceJWithI(text))
        var result = String()
        
        var i = 0
        var j = 1
        
        if tempText.characters.count % 2 != 0 {
            tempText += "x"
        }
        
        while j < tempText.characters.count {
            
            let index1 = tempText.startIndex.advancedBy(i)
            let char1 = tempText[index1]
            
            let index2 = tempText.startIndex.advancedBy(j)
            let char2 = tempText[index2]
            
            if char1 == char2 {
                result.append(char1)
                
                var pad = ""
                if char1 == "x" {
                    pad = "z"
                }
                else {
                    pad = "x"
                }
                
                result += pad
                
                result.append(char2)
            }
            else {
                result.append(char1)
                result.append(char2)
            }
            
            i += 2
            j += 2
        }
        
        return result
    }
    
    func replaceJWithI (text: String) -> String{
        let tempText = text.stringByReplacingOccurrencesOfString("j", withString: "i")
        return tempText
    }
    
    func groupingTheText(text: String) -> [String] {
        let count = text.characters.count / 2
        
        var splitText = [String](count: count, repeatedValue: "")
        
        var i = 0
        var j = 1
        var k = 0
        
        while j < text.characters.count {
            
            let index1 = text.startIndex.advancedBy(i)
            let char1 = text[index1]
            
            let index2 = text.startIndex.advancedBy(j)
            let char2 = text[index2]
            
            splitText[k].append(char1)
            splitText[k].append(char2)
            
            i += 2
            j += 2
            k += 1
        }
        
        return splitText
    }
    
    func getEncryptionValue(text: String, keyTable: [[String]]) -> String {
        var result = String()
        
        let index1 = text.startIndex.advancedBy(0)
        let char1 = text[index1]
        
        let index2 = text.startIndex.advancedBy(1)
        let char2 = text[index2]
        
        // position of the first char in keyTable
        var x1 = 0
        var y1 = 0
        
        // position of the second char in the keyTable
        var x2 = 0
        var y2 = 0
        
        // boolean to indicate if the char found
        var char1Found = false
        var char2Found = false
        
        for i in 0...4 {
            for j in 0...4 {
                let string1 = String(char1)
                let string2 = String(char2)
                
                if string1 == keyTable[i][j] {
                    x1 = i
                    y1 = j
                    
                    char1Found = true
                }
                
                if string2 == keyTable[i][j] {
                    x2 = i
                    y2 = j
                    
                    char2Found = true
                }
                
                if char1Found == true && char2Found == true {
                    break
                }
            }
        }
        
        // nested if else to encrypt the plaintext
        // if both char located in the same row
        if x1 == x2 {
            if y1+1 == 5{
                y1 = 0
            }
            else {
                y1 += 1
            }
            
            if y2+1 == 5{
                y2 = 0
            }
            else {
                y2 += 1
            }
            
            result += keyTable[x1][y1]
            result += keyTable[x2][y2]
        }
            
            // if both char located in the same column
        else if y1 == y2 {
            if x1+1 == 5{
                x1 = 0
            }
            else {
                x1 += 1
            }
            
            if x2+1 == 5{
                x2 = 0
            }
            else {
                x2 += 1
            }
            
            result += keyTable[x1][y1]
            result += keyTable[x2][y2]
        }
            
            // if both char located in different row and column
        else {
            let string1 = keyTable[x2][y1]
            let string2 = keyTable[x1][y2]
            
            if (x1<x2 && y1<y2) || (x1>x2 && y1>y2) {
                result += string1
                result += string2
            }
            else if (x1<x2 && y1>y2) || (x1>x2 && y1<y2) {
                result += string2
                result += string1
            }
        }
        
        return result
    }
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    func checkKey (key: String) -> Bool
    {
        if key == "" {
            return false
        }
        
        for charKey in key.characters {
            if alphabet.characters.contains(charKey) == false {
                return false
            }
        }
        
        return true
    }
    
    
    func getDecryptionValue(text: String, keyTable: [[String]]) -> String {
        var result = String()
        
        let index1 = text.startIndex.advancedBy(0)
        let char1 = text[index1]
        
        let index2 = text.startIndex.advancedBy(1)
        let char2 = text[index2]
        
        // position of the first char in keyTable
        var x1 = 0
        var y1 = 0
        
        // position of the second char in the keyTable
        var x2 = 0
        var y2 = 0
        
        // boolean to indicate if the char found
        var char1Found = false
        var char2Found = false
        
        for i in 0...4 {
            for j in 0...4 {
                let string1 = String(char1)
                let string2 = String(char2)
                
                if string1 == keyTable[i][j] {
                    x1 = i
                    y1 = j
                    
                    char1Found = true
                }
                
                if string2 == keyTable[i][j] {
                    x2 = i
                    y2 = j
                    
                    char2Found = true
                }
                
                if char1Found == true && char2Found == true {
                    break
                }
            }
        }
        
        // nested if else to encrypt the plaintext
        // if both char located in the same row
        if x1 == x2 {
            if y1-1 < 0{
                y1 = 4
            }
            else {
                y1 -= 1
            }
            
            if y2-1 < 0{
                y2 = 4
            }
            else {
                y2 -= 1
            }
            
            result += keyTable[x1][y1]
            result += keyTable[x2][y2]
        }
            
            // if both char located in the same column
        else if y1 == y2 {
            if x1-1 < 0{
                x1 = 4
            }
            else {
                x1 -= 1
            }
            
            if x2-1 < 0{
                x2 = 4
            }
            else {
                x2 -= 1
            }
            
            result += keyTable[x1][y1]
            result += keyTable[x2][y2]
        }
            
            // if both char located in different row and column
        else {
            let string1 = keyTable[x2][y1]
            let string2 = keyTable[x1][y2]
            
            if (x1<x2 && y1<y2) || (x1>x2 && y1>y2) {
                result += string2
                result += string1
            }
            else if (x1<x2 && y1>y2) || (x1>x2 && y1<y2) {
                result += string1
                result += string2
            }
        }
        
        return result
    }
    
    func decryptionButton(text: String, key: String) -> String {
        var plaintext = String()
        let tempText = removeSpecialCharsFromString(text)
        let keyTable = prepareKey(key)
        
        let ciphertext = groupingTheText(tempText)
        
        for i in 0...ciphertext.count-1 {
            plaintext += getDecryptionValue(ciphertext[i], keyTable: keyTable)
        }
        
        return plaintext.uppercaseString
    }
    
    
}
