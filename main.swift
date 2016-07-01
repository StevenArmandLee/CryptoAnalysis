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
func gcd(a: Int, b: Int) -> (Int){
    var (n1, n2) = (abs(a), abs(b))
    while n2 != 0 {
        (n1, n2) = (n2, n1 % n2)
    }
    return n1
}



//inverse module ((a^-1) mod b )
func gcdR(a: Int, b: Int) -> (Int){
    var (n1, n2) = (abs(b), abs(a))
    var (a1, b1, a2, b2) = (1, 0, 0, 1)
    while n2 != 0 {
        
        let q = n1 / n2
        (n1, n2) = (n2, n1 % n2)
        if n2 == 0 {
            break;
        }
        (a1, b1, a2, b2) = (a2, b2, a1 - q * a2, b1 - q * b2)
        print(b2)
    }
    return b + b2
}
//fast exponentiation function ((a^power) mod b)
func fastExpo(a: Int, b: Int, pow: Int) ->(Int){
    //assign a(int)
    var a = a
    //convert power to binary in string
    let  str = String(pow, radix: 2)
    //convert string to char array
    var charArr = [Character](str.characters)
    //reverse the array
    charArr = charArr.reverse()
    var result = 1
    for c in charArr{
        if c == "1"{
            result = (result * a) % b
        }
        a = pwrInt(a,2) % b
    }
    return result
}

var gcdNum = gcdR(337,b: 1394)
print("gcd \(gcdNum)")
//var num = fastExpo(25, b: 123, pow: 166)
//print("mod \(num)")