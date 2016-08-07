//
//  CryptanalysisToolModel.swift
//  Cryptanalysis
//
//  Created by steven lee on 6/8/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class TranspoToolModel {
    
    var column = Int()
    var row = Int()
    var keyNum = [Int]()
    
    // get column
    func getColumn() -> Int {
        return column
    }
    
    // get row
    func getRow() -> Int {
        return row
    }
    
    // get key number
    func getKeyNum() -> [Int] {
        return keyNum
    }
    
    // put the Text to table
    func putTextToTable(text: String, keyLength: String) -> [String]{
        
        let keyTable = getKeyTable(keyLength)
        let col = text.characters.count / keyTable.count
        
        column = col
        row = keyTable.count
        keyNum = keyTable
        
        let table = getTable(text, keyTable: keyNum)
        
        return table
    }
    
    // get the table of text
    func getTable(text: String, keyTable: [Int]) -> [String] {
        var table = [String](count: keyTable.count, repeatedValue: "")
        
        for i in 0...keyTable.count-1 {
            for j in 0...column-1 {
                let pChar = text.startIndex.advancedBy(i + j*keyTable.count)
                table[keyTable[i]].append(text[pChar])
            }
        }
        
        return table
    }
    
    // build a key table
    func getKeyTable(keyLength: String) -> [Int] {
        var table = [Int](count: Int(keyLength)!, repeatedValue: 0)
        
        
        for i in 0...table.count-1 {
            table[i] = i
        }
        
        return table
    }
    
    // get possible length of the key
    func possibleKeyLength(text: String) -> [Int] {
        let len = text.characters.count
        let index = len / 2
        var result = [Int]()
        
        for i in 2...index {
            if len % i == 0 {
                result.append(i)
            }
        }
        return result
    }
    
    // func to swap the key value
    func swapTheKey(int1: Int, int2: Int){
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
        
        for i in 0...keyNum.count-1 {
            if keyNum[i] == temp1 {
                keyNum[i] = temp2
            }
            else if keyNum[i] == temp2 {
                keyNum[i] = temp1
            }
        }
    }
}