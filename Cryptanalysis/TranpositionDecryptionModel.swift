//
//  TranpositionDecryptionModel.swift
//  Cryptanalysis
//
//  Created by Joshua Saputra on 27/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class TranspositionCipher{
    /***********************************************/
    /************ TRANSPOSITION CIPHER *************/
    /***********************************************/
    func transpositionEncryption(text: String, key: String) -> String {
        var ciphertext = String()
        
        var plaintext = text
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
        var keyMap = Array(key.characters)
        var sortKey = Array(key.characters)
        
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
}