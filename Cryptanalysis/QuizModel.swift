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
    var paragraph :[String] = ["It could be that the deeper they lie inside your heart the harder it becomes to reach out to them But if you really begin to cherish every moment then wouldnt that make even the most precious moments merely ordinary a conversation is like a swimming in a painting paint word can never reach u and also my love if i show you my flaw if i couldnt be strong tell me honestly would you still love me the same but i remind myself i have a job to do lets dance together between my chair nothing i can do to help u","Time and gravity are indeed quite similar she was right nher the benefits of a mariage without the nagging responsoblities of a wife and mother. It thus didnt bother at all that after so many years she knew only money, nothing at all really of her husband or her son then i want§ed to go back and look so we can never ever separated from each other forever and kill him do it again and i said he is already dead in the hearth","Dating a new person every day and breaking up with a new person every day Which one would be more difficult I was only nine then too young to fully understand mozart but I watched in awe as the pianist swayed with each note what I remember most though was not What saw on stage basketball whatever skateboarding she stared back with clear blue eyes and a shy smile her hairs locks falling just above her cheeck bones it was this sincere unblemished face that he had fallen in love with so long ago", "I woke up on Saturday morning, not in my bed, but in the hallway I had fallen asleep while watching my father I was immediately embrassed wondering whether or not he had seen me sprawled on the wooden floor I always make sure there is an opening in the room an inch at the door or maybe even at the windows My grandmother taught me that if one dies during sleep the soul needs an exit or it will be forever trapped in the room i stomped on his head 3 times and each time said it was accident little so i satbbed his back out four times then he layed flat and i slit one side oh, the sounds the guys was making were like what you do"]
    
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
        monoDecryption.insertKeyToDictionaryStream(keyWord, userValue: "abcdefghijklmnopqrstuvwxyz")
        cipherText = monoDecryption.applyReplaceUsingDictionaryStream(plainText).lowercaseString
        monoDecryption.resetStreamDictionary()
        
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
        let MIN_KEY_LENGTH = 5
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
