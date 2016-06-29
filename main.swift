//
//  main.swift
//  Calculator
//
//  Created by Yang Guang on 29/6/16.
//  Copyright © 2016 Yang Guang. All rights reserved.
//

import Foundation

// power/math this will takeint in and outputint, cos the pow function only support doublt
let pwrInt:(Int,Int)->Int = { a,b in return Int(pow(Double(a),Double(b))) }

//gcd function
/*func gcd(a: Int, b: Int) -> (Int){
    if a < 1 {
        return gcdR(-pwrInt((1/a),2),n2: b)
    }
    else if b < 1 {
        return gcdR(a,n2: -pwrInt((1/b),2))
    }
    else {
        return gcdR(a,n2: b)
    }
    
}*/

//gcd function if the input value is power of negtive 1 (n^-1) please input -n
func gcdR(n1: Int, n2: Int) -> (Int){

    var (a, b) = (abs(n1), abs(n2))
    var (x, y, z, e) = (1, 0, 0, 1)
    while b != 0 {
        let q = a / b
        (a, b) = (b, a % b)
        if b == 0 {
            break;
        }
        (x, y, z, e) = (z, e, x - q * z, y - q * e)
        print(e)
    }
    var re:Int
    if n1 < 0{
        re = e
        if re < 0{
            re = re + n2
        }
    }
    else if n2 < 0{
        re = e
        if re < 0{
            re = re + n1
        }
    }
    else {
        re = a
    }
    return re
}
//fast exponentiation function
func fastExpo(a: Int, b: Int, pow: Int) ->(Int){
    let  str = String(pow, radix: 2)
    var charArr = [Character](str.characters)
    charArr = charArr.reverse()
    var va = a
    var re = 1
    for c in charArr{
        print(va)
        if c == "1"{
            re = (re * va) % b
        }
        va = pwrInt(va,2) % b
    }
    
    print(str)
    print(charArr)
    return re
}

var gcdNum = gcdR(1394,n2: -337)
print("gcd \(gcdNum)")
//var num = fastExpo(25, b: 123, pow: 166)
//print("mod \(num)")