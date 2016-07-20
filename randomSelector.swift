//
//  RandomSelector.swift
//  utility
//
//  Created by Yang Guang on 18/7/16.
//  Copyright © 2016 Yang Guang. All rights reserved.
//

import Foundation
class Randomselector {
    
func RandomSentence(paragraph : [String]) ->(String){
    if(paragraph.isEmpty){
        return "input error"
    }else{
        //paragraph.count is max size of the array
    let selector = RandomNum(paragraph.count)
    return paragraph[selector]
    }
}

func RandomWords(sentence : String) -> (String){
    if sentence.isEmpty{
        return "input error"
    }else{
    //split string to array string delimiter by space -> " "
    let delimiter = " "
    let token = sentence.componentsSeparatedByString(delimiter)
    let size = token.count
    let selector = RandomNum(size)
    
    var result = SymbolRemover(token[selector])
    //if the random select word is symbol onlt ?, !, }, { .etc
    //will take another change
    if result.characters.count == 0{
        result = RandomWords(sentence)
    }
        return result
    }
    
}

//function to remove all symbols
func SymbolRemover(input_string: String) ->(String){
    let valid_char = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    //remove all in valid char except the char in valid_char
    return String(input_string.characters.filter { String($0).rangeOfCharacterFromSet(NSCharacterSet(charactersInString: valid_char)) != nil })
}

//random generator wich can set the maximun range
func RandomNum(max : Int) -> (Int){
    return Int(arc4random_uniform(UInt32(max)))
}
/* testing for randomWords
for var i = 0; i < 10; i++ {
let result = RandomWords("abc")
print(result)
print(result.characters.count)
}
*/

/*testing for RandomSentence
let string_array = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p"]
for var i = 0; i < 10; i++ {
let result = RandomSentence(string_array)
print(result)
}
*/
}
