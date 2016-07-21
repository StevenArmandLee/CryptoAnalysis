//
//  StasticalModel.swift
//  Cryptanalysis
//
//  Created by steven lee on 12/6/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

public class StasticalModel
{
    let alphabet = "abcdefghijklmnopqrstuvwxyz"
    var data = [String: Double]()
    var trimmedText: String = ""
    
    public func getTrimmedText()-> String
    {
        return trimmedText
    }
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }

    public func generateChart(lengthOfCharacter: Int, isCaseSensitive: Bool, isRemoveSymbol: Bool)
    {
    
        data.removeAll()
    
        trimmedText = globalOriginalText.stringByReplacingOccurrencesOfString(" ", withString: "").stringByReplacingOccurrencesOfString("\n", withString: "")
        
        if(isRemoveSymbol){
            trimmedText = removeSpecialCharsFromString(trimmedText)
        }
        if(!isCaseSensitive){
            trimmedText = trimmedText.lowercaseString
        }
    
        
        //this if is a guard so that it will never be end < start
        if(trimmedText.characters.count >= lengthOfCharacter-1){
                for  i in 0..<trimmedText.characters.count - (lengthOfCharacter-1)
                {
                    let xData =  trimmedText.substringWithRange(trimmedText.startIndex.advancedBy(i)..<trimmedText.startIndex.advancedBy(i+lengthOfCharacter))
                
                    if(data[xData] == nil)
                    {
                        data[xData] = 1
                    }
                    
                    else
                    {
                        data[xData] = data[xData]!+1
                    }
                
                }
        }
        
    
    
    }

    public func getXAxisLabel() -> [String]
    {
        return Array(data.keys).sort(<)
    }

    public func getXAxisData(xAxisLabels: [String]) -> [Double]
    {
        var xAxisData = [Double]()
    
        for i in 0..<xAxisLabels.count
        {
            xAxisData.append(data[xAxisLabels[i]]!)
        }
    
        return xAxisData
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
    public func getStaticalInformation()->String
    {
        var staticalInformation: String = ""
        var xLabels = getXAxisLabel()
        for i in 0..<xLabels.count{
            staticalInformation+=xLabels[i] + "\t\t=\t" + String(Int(data[xLabels[i]]!)) + "\n"
        }
        return staticalInformation
    }
    
    
    func letterFrequency (text : String) -> [Int] {
        var frequencies = [Int](count: 26, repeatedValue: 0)
    
        for ch in text.characters {
            frequencies[findCharNum(ch)] += 1
        }
    
        return frequencies
    }
    
    
    func roundToPlaces(num : Double, places : Int) -> Double {
        let divisor = Double(pow(10, Double(places)))
        return round(num * divisor) / divisor
    }
    func calIC(text : String) -> Double {
        let freq = letterFrequency(text)
        var ic = 0.0
        var sum = 0
        
        for i in freq {
            sum += i
        }
        
        for i in freq {
            let top = Double(i * (i-1))
            let bottom = Double(sum * (sum-1))
            ic += top / bottom
        }
        
        return roundToPlaces(ic, places: 6)
    }

}
