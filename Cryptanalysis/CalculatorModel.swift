//
//  Calculator.swift
//  for testing
//
//  Created by Yang Guang on 9/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//
import Foundation

class CalculatorModel{
    // power/math this will take int in and outputint, cos the pow function only support doublt
    let pwrInt:(Int,Int)->Int = { number,power in return Int(pow(Double(number),Double(power))) }
    
    //normal gcd function to get the greatest common divisor between nmuber a & b
    func gcd(number_1: Int, number_2: Int) -> (String){
        var (n1, n2) = (number_1, number_2)
        while n2 != 0 {
            //n1%n2 is the reminder
            (n1, n2) = (n2, n1 % n2)
        }
        return ("\(n1)")
    }
    
    
    
    //multiplicative iverse of dividend(dividend^-1) mod divisor
    func gcdR(dividend: Int, divisor: Int) -> (String){
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
            print(" \(a1),  \(b1), \(a2), \(b2)")
            //all_steps += "\n" + a1 + " " + a1 + " " a1 + " " a1 + " " a1 + " " a1 + " "; a1
        }
        if n1 != 1 {
            return ("There is no multiplicative inverse exist")
        }else{
            if divisor < dividend{
                b2 = a2
            }
            if b2 > 0{
                return ("\(b2)")
            }else{
                return ("\(divisor + b2)")
            }
        }
    }
    //fast exponentiation function ((base^exponent) mod modulus)
    func fastExpo(base: Int, modulus: Int, exponent: Int) ->(String){
        //assign a(int)
        var a = base%modulus
        //convert power to binary in string
        let  str = String(exponent, radix: 2)
        //convert string to char array
        var charArr = [Character](str.characters)
        //reverse the array
        charArr = charArr.reverse()
        var result = 1
        for c in charArr{
            if c == "1"{
                result = (result * a) % modulus
            }
            if result == 0{
                break;
            }
            //a = pwrInt(a,2) % modulus
            //due to the limitation cannot use build-in power function
            a = (a*a) % modulus
            
            
        }
        return ("\(result)")
    }
}
