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
        try super.setUpWithError()
        app = XCUIApplication()
        app.launchArguments = ["toTestSignUpController"]
        app.launch()
        
        email = app.textFields["emailTextField"]
        username = app.textFields["usernameTextField"]
        password = app.secureTextFields["passwordTextField"]
        plusPhotoButton = app.buttons["plusPhotoButton"]
        signUpButton = app.buttons["signUpButton"]
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
        email = nil
        username = nil
        password = nil
        plusPhotoButton = nil
        signUpButton = nil
        
        try super.tearDownWithError()
    }

    func testSignUpController_WhenViewLoaded_RequiredUIElementsAreRightStatus() throws {
        XCTAssertTrue(email.isEnabled, "Email UITextField is not enabled for user interactions")
        XCTAssertTrue(username.isEnabled, "username UITextField is not enabled for user interactions")
        XCTAssertTrue(password.isEnabled, "password UITextField is not enabled for user interactions")
        XCTAssertTrue(plusPhotoButton.isEnabled, "plus Photo Button is not enabled for user interactions")
        XCTAssertFalse(signUpButton.isEnabled, "sign Up Button is enabled for user interactions")

    }
    
    func testSignUpController_WhenValidFormSubmitted_SignUpButtonIsEnabled() {
        // Arrange
        email.tap()
        email.typeText("Demo@mail.com")
        
        username.tap()
        username.typeText("Demo")
        
        password.tap()
        password.typeText("qaz123")
        // Assert
        XCTAssertTrue(signUpButton.isEnabled, "sign Up Button is not enabled for user interactions")
    }
}
