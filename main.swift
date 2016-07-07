//
//  main.swift
//  Calculator
//
//  Created by Yang Guang on 29/6/16.
//  Copyright © 2016 Yang Guang. All rights reserved.
//

import Foundation

// power/math this will take int in and outputint, cos the pow function only support doublt
let pwrInt:(Int,Int)->Int = { number,power in return Int(pow(Double(number),Double(power))) }

//normal gcd function to get the greatest common divisor between nmuber a & b
func gcd(number_1: Int, number_2: Int) -> (String){
    var (n1, n2) = (number_1, number_2)
    while n2 != 0 {
        //n1%n2 is the reminder
        (n1, n2) = (n2, n1 % n2)
    }
    return ("gcd(\(number_1), \(number_1)) = \(n1)")
}



//multiplicative iverse of dividend(dividend^-1) mod divisor
func gcdR(dividend: Int, divisor: Int) -> (String){
    //assign n1 & n2
    var (n1, n2) = (divisor, dividend)
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

    }
    if n1 != 1 {
        return ("Since gcd(\(dividend), \(divisor)) = \(n1), there is no multiplicativeinverse exist")
    }else{
    return ("\(dividend)^-1 mod \(divisor) = \(divisor + b2)")
}
}
//fast exponentiation function ((dividend^power) mod divisor)
func fastExpo(dividend: Int, divisor: Int, power: Int) ->(Int){
    //assign a(int)
    var a = dividend
    //convert power to binary in string
    let  str = String(power, radix: 2)
    //convert string to char array
    var charArr = [Character](str.characters)
    //reverse the array
    charArr = charArr.reverse()
    var result = 1
    for c in charArr{
        if c == "1"{
            result = (result * a) % divisor
        }
        a = pwrInt(a,2) % divisor
    }
    return result
}

var gcdNum = gcdR(1234, divisor: 120)
print("gcd \(gcdNum)")
//var num = fastExpo(25, b: 123, pow: 166)
//print("mod \(num)")