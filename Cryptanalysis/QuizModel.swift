//
//  QuizModel.swift
//  Cryptanalysis
//
//  Created by Joshua Saputra on 27/7/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import Foundation

class QuizModel{
    //Encryptor Object
    private let monoDecryption = MonoDecryptionModel()
    private let affineCipher = AffineDecryption()
    private let transpositionCipher = TranspositionDecryptionModel()
    private let playfairCipher = PlayfairDecryptionModel()
    private let polyDecryption = PolyDecryptionModel()
    private let shiftDecryption = ShiftDecryptionModel()
    
    //Source
    var paragraph :[String] = ["It could be that\n the deeper they lie inside your heart the harder it becomes to reach out to them","But if you really begin to cherish every moment then wouldnt that make even the most precious moments merely ordinary","Time and gravity are indeed quite similar","Dating a new person every day and breaking up with a new person every day Which one would be more difficult"]
    
    //Data
    var plainText :String = ""
    var keyWord :String = ""
    var keyAlpha :Int = -1
    var keyBeta :Int = -1
    var cipherText :String = ""
    
    
    //8 Main Functions
    func generateMonoalphabetic(){
        //Generate Plaintext and Key
        plainText = RandomSentence().lowercaseString
        let keyWordTemp = RandomWords(RandomSentence())
        
        //Setting Key
        keyWord = monoDecryption.removeDuplicateLetterFromString(keyWordTemp)
        keyWord = monoDecryption.autoFillKeyString(keyWord)
        
        //Encryption
        print(keyWord)
        monoDecryption.insertKeyToDictionaryStream(keyWord, userValue: "abcdefghijklmnopqrstuvwxyz")
        cipherText = monoDecryption.applyReplaceUsingDictionaryStream(plainText).lowercaseString
        monoDecryption.resetDictionary()
        
        keyWord = keyWordTemp
    }
    
    func generateVigenereCipher(){
        //Generate Plaintext and key
        plainText = RandomSentence()
        keyWord = RandomWords(RandomSentence())
        
        //Encryption
        cipherText = polyDecryption.vigenereEncryption(plainText.uppercaseString, key: keyWord).lowercaseString
    }
    
    func generateBeaufortCipher(){
        //Generate Plaintext and key
        plainText = RandomSentence()
        keyWord = RandomWords(RandomSentence())
        
        //Encryption
        cipherText = polyDecryption.beaufortEncryption(plainText.uppercaseString, key: keyWord).lowercaseString
    }
    
    func generateAffineCipher(){
        //Generate Plaintext and Keys
        plainText = RandomSentence()
        keyAlpha = RandomNum(25)
        while keyAlpha == 13 || keyAlpha%2 == 0 || keyAlpha == 0{
            keyAlpha = RandomNum(25)
        }
        keyBeta = RandomNum(25)
        keyWord = "\(keyAlpha) and \(keyBeta)"
        
        //Encryption
        cipherText = affineCipher.applyAffineEncryptionUsingKey(plainText.uppercaseString, alphaKey: keyAlpha, betaKey: keyBeta).lowercaseString
    }
    
    func generateShiftLeftCipher(){
        //Generate PlainText and Keys
        plainText = RandomSentence()
        keyAlpha = RandomNum(25)
        while keyAlpha == 0{
            keyAlpha = RandomNum(25)
        }
        keyWord = "\(keyAlpha)"
        
        //Encryption
        cipherText = shiftDecryption.shiftLeftEncryption(plainText.uppercaseString, key: String(keyAlpha)).lowercaseString
    }
    
    func generateShiftRightCipher(){
        //Generate PlainText and Keys
        plainText = RandomSentence()
        keyAlpha = RandomNum(25)
        while keyAlpha == 0{
            keyAlpha = RandomNum(25)
        }
        keyWord = "\(keyAlpha)"
        
        //Encryption
        cipherText = shiftDecryption.shiftRightEncryption(plainText.uppercaseString, key: String(keyAlpha)).lowercaseString
    }
    
    func generateTranspositionCipher(){
        //Generate Plaintext and Key
        plainText = RandomSentence()
        keyWord = RandomWords(RandomSentence())
        
        //Encryption
        cipherText = transpositionCipher.transpositionEncryption(plainText.uppercaseString, key: keyWord)
    }
    
    func generatePlayfairCipher(){
        //Generate Plaintext and Key
        plainText = RandomSentence()
        keyWord = RandomWords(RandomSentence())
        
        //Encryption
        cipherText = playfairCipher.playFairEncryption(plainText.uppercaseString, key: keyWord).lowercaseString
    }
    
    //Accessor
    func getPlainText()->String{
        return plainText;
    }
    
    func getKeyWord()->String{
        return keyWord
    }
    
    func getCipherText()->String{
        return cipherText
    }
    
    
    
    //Random Function to choose Paragraph and Word
    func RandomSentence() ->(String){
        if(paragraph.isEmpty){
            return "input error"
        }else{
            //paragraph.count is max size of the array
            let selector = RandomNum(paragraph.count)
            return paragraph[selector]
        }
    }
    
    func RandomWords(sentence : String) -> (String){
        let MIN_KEY_LENGTH = 4
        if sentence.isEmpty{
            return "input error"
        }else{
            //split string to array string delimiter by space -> " "
            let delimiter = " "
            let token = sentence.componentsSeparatedByString(delimiter)
            let size = token.count
            let selector = RandomNum(size)
            
            var result = SymbolRemover(token[selector])
            
            if result.characters.count < MIN_KEY_LENGTH{
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
    
    
    
    
    
}
