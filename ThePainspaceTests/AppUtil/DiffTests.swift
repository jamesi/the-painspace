//
//  DiffTests.swift
//  ThePainspaceTests
//
//  Created by James Ireland on 11/12/2018.
//  Copyright © 2018 James Ireland. Available under the MIT license.
//

import XCTest
@testable import ThePainspace

class DiffTestsTests: XCTestCase {
    
    func testDiffInts() {
        let from = [0, 1, 2, 3]
        let to = [2, 1, 0, 4]
        let result = diff(from: from, to: to)
        
        print(result)
    }

    func testDiffStrings() {
        let from = ["Zero", "One", "Two", "Three"]
        let to = ["Two", "One", "Zero", "Four"]
        let result = diff(from: from, to: to)
        
        print(result)
    }
    
}
