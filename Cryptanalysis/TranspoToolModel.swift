//
//  CryptanalysisToolModel.swift
//  Cryptanalysis
//
//  Created by steven lee on 6/8/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class TranspoToolModel {

    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    func analyzeByPeriod(text: String, period: Int) -> String{
        
        var trimmedText = removeSpecialCharsFromString(text)
        trimmedText = trimmedText.stringByReplacingOccurrencesOfString(" ", withString: "").stringByReplacingOccurrencesOfString("\n", withString: "")
        trimmedText = trimmedText.uppercaseString
        
        var result = ""
        
        if period == 1 || period == 0 {
            result = trimmedText
            result = addingTab(result)
            
            return result
        }
        
        var keyTable = getKeyTable(period)
        keyTable = swapTheKey(keyTable, int1: period-2, int2: period-1)
        
        let table = getTable(trimmedText, keyTable: keyTable)
        let col = trimmedText.characters.count / period
        
        var remainder = trimmedText.characters.count % period
        
        for i in 0...col-1 {
            for str in table {
                let char = str.startIndex.advancedBy(i)
                result.append(str[char])
            }
        }
        
        if remainder != 0 {
            while remainder != 0 {
                let char = trimmedText.startIndex.advancedBy(trimmedText.characters.count-remainder)
                result.append(trimmedText[char])
                remainder -= 1
            }
        }
        
        result = addingTab(result)
        
        return result
    }
    
    func addingTab(text: String) -> String{
        var result = "\t\t"
        
        var j = 0
        var i = 0
        var checker = false
        
        while checker == false {
            j += 5
            
            if j >= text.characters.count{
                checker = true
                break
            }
            
            result += text[text.startIndex.advancedBy(i)...text.startIndex.advancedBy(j-1)]
            result += "\t\t"
            i += 5
        }
        
        return result
    }
    
    // get the table of text
    func getTable(text: String, keyTable: [Int]) -> [String] {
        var table = [String](count: keyTable.count, repeatedValue: "")
        let col = text.characters.count / keyTable.count
        
        for i in 0...keyTable.count-1 {
            for j in 0...col-1 {
                let pChar = text.startIndex.advancedBy(i + j*keyTable.count)
                table[keyTable[i]].append(text[pChar])
            }
        }
        
        return table
    }
    
    // build a key table
    func getKeyTable(keyLength: Int) -> [Int] {
        var table = [Int](count: keyLength, repeatedValue: 0)
        
        
        for i in 0...table.count-1 {
            table[i] = i
        }
        
        return table
    }
    
    // func to swap the key value
    func swapTheKey(keyTable: [Int], int1: Int, int2: Int) -> [Int]{
        
        var result = keyTable
        var temp1 = Int()
        var temp2 = Int()
        
        if int1 < int2 {
            temp1 = int1
            temp2 = int2
        }
        else {
            temp1 = int2
            temp2 = int1
        }
        
        for i in 0...result.count-1 {
            if result[i] == temp1 {
                result[i] = temp2
            }
            else if result[i] == temp2 {
                result[i] = temp1
            }
        }
        return result
    }
}