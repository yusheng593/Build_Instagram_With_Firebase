//
//  SignUpFlowTests.swift
//  Build_Instagram_With_FirebaseUITests
//
//  Created by yusheng Lu on 2022/12/13.
//

import XCTest

class SignUpFlowTests: XCTestCase {
    
    private var app: XCUIApplication!
    private var email: XCUIElement!
    private var username: XCUIElement!
    private var password: XCUIElement!
    private var plusPhotoButton: XCUIElement!
    private var signUpButton: XCUIElement!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
        
        email = app.textFields["emailTextField"]
        username = app.textFields["usernameTextField"]
        password = app.secureTextFields["passwordTextField"]
        plusPhotoButton = app.buttons["plusPhotoButton"]
        signUpButton = app.buttons["signUpButton"]

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        email = nil
        username = nil
        password = nil
        plusPhotoButton = nil
        signUpButton = nil
        
        try super.tearDownWithError()
    }

    func testViewController_WhenViewLoaded_RequiredUIElementsAreEnabled() throws {
        // UI tests must launch the application that they test.
        XCTAssertTrue(email.isEnabled, "Email UITextField is not enabled for user interactions")
        XCTAssertTrue(username.isEnabled, "username UITextField is not enabled for user interactions")
        XCTAssertTrue(password.isEnabled, "password UITextField is not enabled for user interactions")
        XCTAssertTrue(plusPhotoButton.isEnabled, "plus Photo Button is not enabled for user interactions")
        XCTAssertTrue(signUpButton.isEnabled, "sign Up Button is not enabled for user interactions")

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
