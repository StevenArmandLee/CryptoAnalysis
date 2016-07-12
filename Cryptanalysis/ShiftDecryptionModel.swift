//
//  ShiftDecryptionModel.swift
//  Cryptanalysis
//
//  Created by Branata Kurniawan on 12/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class ShiftDecryptionModel {
    
    private var currentOffset = Int()
    let alphabet = "abcdefghijklmnopqrstuvwxyz"
    let numeric = "0123456789"
    
    func ShiftDecryptionModel(){
        currentOffset = 0
    }
    
    func getCurrentOffset() -> Int {
        return currentOffset
    }
    
    func findCharNum(c : Character) -> Int {
        var index = 0
        
        if let idx = alphabet.characters.indexOf(c) {
            index = alphabet.startIndex.distanceTo(idx)
        }else {
            // cannot find the char in the alphanumeric
            index = -1
        }
        
        return index
    }
    
    func getChar (index : Int) -> Character {
        let pchar = alphabet.startIndex.advancedBy(index)
        return (alphabet[pchar])
    }
    
    func decryptionButton (ctext : String, offset : String, type : String) -> String {
        
        let intOffset = Int(offset)
        
        if type == "Left" {
            currentOffset -= intOffset!
        }
        else{
            currentOffset += intOffset!
        }
        
        if currentOffset > 26 || currentOffset < 0{
            currentOffset = 0
            return ctext
        }
        
        let lengthOfCtext = ctext.characters.count
        var ptext = String()
        
        for i in 0..<lengthOfCtext {
            let indexOfCtext = ctext.startIndex.advancedBy(i)
            
            let ctextNum = findCharNum(ctext[indexOfCtext])
            
            if ctextNum == -1 {
                ptext.append(ctext[indexOfCtext])
            }
            else{
                
                var index = 0
                
                if type == "Left" {
                    index = ctextNum - currentOffset
                }
                else{
                    index = ctextNum + currentOffset
                }
                
                if index < 0 {
                    index = index + 26
                }
                else if index >= 26 {
                    index = index - 26
                }
                ptext.append(getChar(index))
            }
        }
        
        return ptext
    }
    
    func checkKey (offset : String) -> Bool {
        
        if offset == "" {
            return false
        }
        
        if currentOffset > 26{
            return false
        }
        
        for charKey in offset.characters {
            if numeric.characters.contains(charKey) == false {
                return false
            }
        }
        
        return true
    }
}