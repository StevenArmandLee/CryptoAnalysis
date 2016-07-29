//
//  TranpositionDecryptionModel.swift
//  Cryptanalysis
//
//  Created by Joshua Saputra on 27/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class TranspositionDecryptionModel{
    
    let numeric = "0123456789"
    
    /***********************************************/
    /************ TRANSPOSITION CIPHER *************/
    /***********************************************/
    func transpositionEncryption(text: String, key: String) -> String {
        var ciphertext = String()
        
        var plaintext = removeSpecialCharsFromString(text)
        
        let remainder = plaintext.characters.count % key.characters.count
        
        if remainder != 0 {
            for _ in 0...key.characters.count-remainder-1 {
                plaintext.append(randomChar())
            }
        }
        
        let col = plaintext.characters.count / key.characters.count
        
        let keyTable = getKeyTable(key)
        
        var ctextTemp = [String](count: key.characters.count+1, repeatedValue: "")
        
        for i in 0...key.characters.count-1 {
            for j in 0...col-1 {
                let pChar = plaintext.startIndex.advancedBy(i + j*key.characters.count)
                ctextTemp[keyTable[i]].append(plaintext[pChar])
            }
        }
        
        for i in 0...key.characters.count {
            ciphertext = ciphertext + ctextTemp[i]
        }
        
        return ciphertext.uppercaseString
    }
    
    
    // return a random char
    func randomChar() -> Character {
        let randomNum = random() % 26
        let char = numeric_Translator[randomNum]!
        return char
    }
    
    
    // to convert the key into set of different number, the key can be either word or number or can have two/three the same number or letter
    func getKeyTable(key: String) -> [Int] {
        var table = [Int](count: key.characters.count, repeatedValue: 0)
        let tempKey = key.uppercaseString
        
        var keyMap = Array(tempKey.characters)
        var sortKey = Array(tempKey.characters)
        
        sortKey = sortKey.sort()
        
        for i in 0...sortKey.count-1 {
            for j in 0...keyMap.count-1 {
                if sortKey[i] == keyMap[j] {
                    table[i] = j
                    keyMap[j] = Character(UnicodeScalar(10))
                    break
                }
            }
        }
        
        return table
    }
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
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
    
    // decrypt the text using transposition decipher
    func decryptionButton(text: String, key: String) -> String {
        
        var plaintext = String()
        let ciphertext = removeSpecialCharsFromString(text)
        
        let col = ciphertext.characters.count / key.characters.count
        let keyTable = getKeyTable(key)
        
        for i in 0...col-1 {
            for j in 0...key.characters.count-1 {
                let cChar = ciphertext.startIndex.advancedBy(col * keyTable[j] + i)
                plaintext.append(ciphertext[cChar])
            }
        }
        
        return plaintext
        
    }
}