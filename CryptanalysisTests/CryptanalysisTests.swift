//
//  CryptanalysisTests.swift
//  CryptanalysisTests
//
//  Created by steven lee on 11/5/16.
//  Copyright © 2016 steven lee. All rights reserved.
//

import XCTest
@testable import Cryptanalysis

class CryptanalysisTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTools() {
        let transpoToolModel = TranspoToolModel()
        let affineDecryptionModel = AffineDecryption()
        XCTAssertEqual(transpoToolModel.removeSpecialCharsFromString("~!@#$%^&*()_+|}{[]:;?><,./"), "")
        
        let monoDecryptionModel = MonoDecryptionModel()
        XCTAssertEqual(monoDecryptionModel.dictionaryStream,
                       ["a" : "a", "k" : "k", "u" : "u",
            "b" : "b", "l" : "l", "v" : "v",
            "c" : "c", "m" : "m", "w" : "w",
            "d" : "d", "n" : "n", "x" : "x",
            "e" : "e", "o" : "o", "y" : "y",
            "f" : "f", "p" : "p", "z" : "z",
            "g" : "g", "q" : "q",
            "h" : "h", "r" : "r",
            "i" : "i", "s" : "s",
            "j" : "j", "t" : "t",])
        
        XCTAssertEqual(alphabet_Translator, ["A" : 0, "B" : 1, "C" : 2, "D" : 3, "E" : 4, "F" : 5, "G" : 6, "H" : 7, "I" : 8, "J" : 9, "K" : 10, "L" : 11, "M" : 12, "N" : 13, "O" : 14, "P" : 15, "Q" : 16, "R" : 17, "S" : 18, "T" : 19, "U" : 20, "V" : 21, "W" : 22, "X" : 23, "Y" : 24, "Z" : 25,"a" : 0, "b" : 1, "c" : 2, "d" : 3, "e" : 4, "f" : 5, "g" : 6, "h" : 7, "i" : 8, "j" : 9, "k" : 10, "l" : 11, "m" : 12, "n" : 13, "o" : 14, "p" : 15, "q" : 16, "r" : 17, "s" : 18, "t" : 19, "u" : 20, "v" : 21, "w" : 22, "x" : 23, "y" : 24, "z" : 25])
        
        XCTAssertEqual(numeric_Translator, [0 : "A", 1 : "B", 2 : "C", 3 : "D", 4 : "E", 5 : "F", 6 : "G", 7 : "H", 8 : "I", 9 : "J", 10 : "K", 11 : "L", 12 : "M", 13 : "N", 14 : "O", 15 : "P", 16 : "Q", 17 : "R", 18 : "S", 19 : "T", 20 : "U", 21 : "V", 22 : "W", 23 : "X", 24 : "Y", 25 : "Z"])
        
        XCTAssertEqual(affineDecryptionModel.gcdR(2,divisor: 3), 2)
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
