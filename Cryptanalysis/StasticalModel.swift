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
    var data = [String: Double]()
    var trimmedText: String = ""
    
    public func getTrimmedText()-> String
    {
        return trimmedText
    }

    public func generateChart(lengthOfCharacter: Int)
    {
    
        data.removeAll()
    
        trimmedText = globalOriginalText.stringByReplacingOccurrencesOfString(" ", withString: "").stringByReplacingOccurrencesOfString("\n", withString: "")
    
    
        for  i in 0..<trimmedText.characters.count - (lengthOfCharacter-1)
            {
                let xData =  trimmedText.substringWithRange(trimmedText.startIndex.advancedBy(i)..<trimmedText.startIndex.advancedBy(i+lengthOfCharacter)).lowercaseString
            
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

    public func getStaticalInformation()->String
    {
        var staticalInformation: String = ""
        for(dataLabel, dataInformation) in data
        {
            staticalInformation+=dataLabel + "\t\t=\t" + String(Int(dataInformation)) + "\n"
        }
    
        return staticalInformation
    }

}