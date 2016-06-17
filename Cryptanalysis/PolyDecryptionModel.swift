//
//  PolyDecryptionModel.swift
//  Cryptanalysis
//
//  Created by steven lee on 11/6/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class PolyDecryptionModel {
    
    let alphanumeric = "abcdefghijklmnopqrstuvwxyz"
    
    func findCharNum(c : Character) -> Int
    {
        var index = 0
        
        if let idx = alphanumeric.characters.indexOf(c) {
            index = alphanumeric.startIndex.distanceTo(idx)
        }else {
            // cannot find the char in the alphanumeric
            index = -1
        }
        
        return index
    }
    
    func getChar (index : Int) -> Character
    {
        let pchar = alphanumeric.startIndex.advancedBy(index)
        return (alphanumeric[pchar])
    }
    
    func decryptionButton (ctext : String, key : String) -> String
    {
        
        let lengthOfCtext = ctext.characters.count
        let lengthOfKey = key.characters.count
        var ptext = String()
        var count = 0
        
        for i in 0..<lengthOfCtext {
            let indexOfCtext = ctext.startIndex.advancedBy(i)
            
            
            let ctextNum = findCharNum(ctext[indexOfCtext])
            
            if ctextNum == -1 {
                ptext.append(ctext[indexOfCtext])
            }
            else{
                let indexOfKey = key.startIndex.advancedBy(count % lengthOfKey)
                let keyNum = findCharNum(key[indexOfKey])
                var index = ctextNum - keyNum
                if index < 0 {
                    index = index + 26
                }
                ptext.append(getChar(index))
                count += 1
            }
        }
        
        return ptext
    }
}