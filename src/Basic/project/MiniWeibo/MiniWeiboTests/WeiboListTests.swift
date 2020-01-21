//
//  WeiboListTests.swift
//  MiniWeiboTests
//
//  Created by Weicheng Wang on 2020/1/21.
//  Copyright © 2020 ThoughtWorks. All rights reserved.
//

import UIKit
import XCTest
import Quick
import Nimble

@testable import MiniWeibo

class WeiboListTests: XCTestCase {
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testExample() {
        
    }

}

extension XCTestCase {
    func viewTester(_ file : String = #file, _ line : Int = #line) -> KIFUIViewTestActor {
        return KIFUIViewTestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(_ file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

class WeiboListTests: KIFTestCase {
    
    func testGreenCellWithIdentifier() {
        viewTester().usingIdentifier("Green Cell Identifier").tap()
//        viewTester().usingIdentifier("Selected: Green Color").waitForView()
    }
}
