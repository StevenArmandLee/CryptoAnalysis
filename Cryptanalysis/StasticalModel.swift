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
    var polyData = [String: Double]()
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
    
    func initializeDic() -> [String:Double]{
        let dictionary:[String:Double] =  [
            "a" : 0.0, "k" : 0.0, "u" : 0.0,
            "b" : 0.0, "l" : 0.0, "v" : 0.0,
            "c" : 0.0, "m" : 0.0, "w" : 0.0,
            "d" : 0.0, "n" : 0.0, "x" : 0.0,
            "e" : 0.0, "o" : 0.0, "y" : 0.0,
            "f" : 0.0, "p" : 0.0, "z" : 0.0,
            "g" : 0.0, "q" : 0.0,
            "h" : 0.0, "r" : 0.0,
            "i" : 0.0, "s" : 0.0,
            "j" : 0.0, "t" : 0.0,
            ]
        
        
        
        return dictionary
    }
    func getSubString(text : String, idx : Int, period : Int) -> String {
        var subString = ""
        var j = idx
        while j < text.characters.count {
            let index = text.startIndex.advancedBy(j)
            subString.append(text[index])
            j = j+period
        }
        
        return subString
    }
    func getDictionary(text : String, index: Int, period: Int) -> [String:Double]{
        var dictionary = initializeDic();
        let subString = getSubString(text, idx: index, period: period)
    
        for ch in subString.characters {
            let tempString = String(ch)
            let oldVal = dictionary[tempString]
            dictionary.updateValue(oldVal!+1, forKey: tempString)
        }
        print(dictionary)
        return dictionary
    }
    
    func generatePolyGraph(index: Int, period: Int){
        trimmedText = globalOriginalText.stringByReplacingOccurrencesOfString(" ", withString: "").stringByReplacingOccurrencesOfString("\n", withString: "")
        polyData = getDictionary(removeSpecialCharsFromString(trimmedText).lowercaseString, index: index, period: period)
        print(polyData)
    }
    
    func getPolyGraphXLabel() -> [String] {
        return Array(polyData.keys).sort(<)
    }
    
    public func getPolyXAxisData() -> [Double]{
        var xAxisLabels = getPolyGraphXLabel()
        var xAxisData = [Double]()
        
        for i in 0..<xAxisLabels.count
        {
            xAxisData.append(polyData[xAxisLabels[i]]!)
        }
        
        
        return xAxisData
    }

}
