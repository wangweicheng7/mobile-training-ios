//
//  TestCase+Ex.swift
//  MiniWeiboTests
//
//  Created by Weicheng Wang on 2020/1/20.
//  Copyright © 2020 ThoughtWorks. All rights reserved.
//

import XCTest
import KIF

@testable import MiniWeibo

extension XCTestCase {
    func viewTester(_ file : String = #file, _ line : Int = #line) -> KIFUIViewTestActor {
        return KIFUIViewTestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(_ file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }

}

class WeiboListTest: KIFTestCase {
    
    func testGreenCellWithIdentifier() {
        viewTester().usingIdentifier("Green Cell Identifier").tap()
        viewTester().usingIdentifier("Selected: Green Color").waitForView()
    }
    
    func testBlueCellWithLabel() {
        viewTester().usingLabel("Blue Cell Label").tap()
        viewTester().usingLabel("Selected: Blue Color").waitForView()

    }

    func testLogin() {
        noInputLogin()
        noValidateLogin()
        validateLogin()
        agreeValidateLogin()
    }
    
    func testAdd() {
        let a = 3
        let b = 4
        XCTAssert(a+b == 7, "计算正确")
    }
    
    func testnoValidateLogin(){
        
        let userNameInput = tester().usingLabel("login_phone")
        userNameInput?.enterText("15856885688")
        let loginBtn =  tester().usingLabel("登录")
        loginBtn?.tap()
        tester().wait(forTimeInterval: 2)
    }
    
    func noInputLogin(){
        let loginBtn =  tester().usingLabel("登录")
        loginBtn?.tap()
        tester().wait(forTimeInterval: 2)
    }
    
    func noValidateLogin(){
        
        let userNameInput = tester().usingLabel("login_phone")
        userNameInput?.enterText("15856885688")
        let loginBtn =  tester().usingLabel("登录")
        loginBtn?.tap()
        tester().wait(forTimeInterval: 2)
        
    }
    
    func validateLogin(){
        let invalicaodeInput = tester().usingLabel("login_input_invlicode")
        invalicaodeInput?.enterText("123456")
        let valicodeBtn = tester().usingLabel("获取验证码")
        valicodeBtn?.tap()
        let loginBtn =  tester().usingLabel("登录")
        loginBtn?.tap()
        tester().wait(forTimeInterval: 2)
    }
    
    func agreeValidateLogin(){
        
        let login_agree = tester().usingLabel("login_agree")
        login_agree?.tap()
        let loginBtn =  tester().usingLabel("登录")
        loginBtn?.tap()
        let firstPage = tester().usingLabel("首页").waitForView()
        if  (firstPage != nil) {
            loginOut()
        } else {
            XCTAssert(false, "未找到页面")
        }
    }
    
    func loginOut(){
        let meBtn = tester().usingLabel("我")
        meBtn?.tap()
        
        let setUpBtn = tester().usingLabel("设置")
        setUpBtn?.tap()
        
        let outBtn = tester().usingLabel("退出登录")
        outBtn?.tap()
        
        tester().wait(forTimeInterval: 5)
    }
}

