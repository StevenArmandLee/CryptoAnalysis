//
//  AffineDecryptionModel.swift
//  Cryptanalysis
//
//  Created by Joshua Saputra on 27/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class AffineDecryption{
    
    //Affine Cipher
    //---------------------------------------------------------------------------------
    func gcdR(dividend: Int, divisor: Int) -> Int{
        //assign n1 & n2
        var (n1, n2) = (divisor, dividend)
        //var all_steps
        if  divisor < dividend{
            (n1, n2) = (dividend, divisor)
        }
        var (a1, b1, a2, b2) = (1, 0, 0, 1)
        while n2 != 0 {
            
            let quotient = n1 / n2
            //n1%n2 is the reminder
            (n1, n2) = (n2, n1 % n2)
            if n2 == 0 {
                break;
            }
            (a1, b1, a2, b2) = (a2, b2, a1 - quotient * a2, b1 - quotient * b2)
            //all_steps += "\n" + a1 + " " + a1 + " " a1 + " " a1 + " " a1 + " " a1 + " "; a1
        }
        if n1 != 1 {
            return -1
        }else{
            return (divisor+b2)
        }
    }
    func applyAffineEncryptionUsingKey(globalText :String, alphaKey : Int, betaKey :Int)->String{
        var stringResult = ""
        for char in globalText.characters{
            if char != " "{
                let charInNumberForm = alphabet_Translator[char]
                var afterEncryptionNumber = alphaKey*(charInNumberForm)! + betaKey
                afterEncryptionNumber %= 26
                if(afterEncryptionNumber < 0){
                    afterEncryptionNumber += 26
                }
                stringResult += String(numeric_Translator[afterEncryptionNumber]!)
            }
            else{
                stringResult += String(char)
            }
        }
        return stringResult
    }
    
    func applyAffineDecryptionUsingKey(globalText :	 String, alphaKey :Int, betaKey :Int)->String{
        var stringResult = ""
        for char in globalText.characters{
            if char != " "{
                let charInNumberForm = alphabet_Translator[char]
                let newAlphaKey = gcdR(Int(alphaKey), divisor:26)
                var afterEncryptionNumber = ((charInNumberForm)! - betaKey)*newAlphaKey
                afterEncryptionNumber %= 26
                if(afterEncryptionNumber < 0){
                    afterEncryptionNumber += 26
                }
                stringResult += String(numeric_Translator[afterEncryptionNumber]!)
            }
            else{
                stringResult += String(char)
            }
        }
        return stringResult
    }
}