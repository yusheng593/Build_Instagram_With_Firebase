//
//  LoginFlowTests.swift
//  Build_Instagram_With_FirebaseUITests
//
//  Created by yusheng Lu on 2022/12/31.
//

import XCTest

final class LoginFlowTests: XCTestCase {
    
    private var app: XCUIApplication!
    private var email: XCUIElement!
    private var password: XCUIElement!
    private var loginButton: XCUIElement!
    private var dontHaveAccountButton: XCUIElement!
    private var alreadyHaveAccountButton: XCUIElement!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launchArguments = ["toTestLoginController"]
        app.launch()
        
        email = app.textFields["emailTextField"]
        password = app.secureTextFields["passwordTextField"]
        loginButton = app.buttons["loginButton"]
        dontHaveAccountButton = app.buttons["dontHaveAccountButton"]
        alreadyHaveAccountButton = app.buttons["alreadyHaveAccountButton"]
        
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
        email = nil
        password = nil
        loginButton = nil
        dontHaveAccountButton = nil
        alreadyHaveAccountButton = nil
        
        try super.tearDownWithError()
    }

    func testLoginController_WhenViewLoaded_RequiredUIElementsAreRightStatus() throws {
        XCTAssertTrue(email.isEnabled, "Email UITextField is not enabled for user interactions")
        XCTAssertTrue(password.isEnabled, "password UITextField is not enabled for user interactions")
        XCTAssertFalse(loginButton.isEnabled, "sign Up Button is enabled for user interactions")
        XCTAssertTrue(dontHaveAccountButton.isEnabled, "dontHaveAccountButton is enabled for user interactions")
    }
    
    func testLoginController_WhenValidFormSubmitted_SignUpButtonIsEnabled() {
        // Arrange
        email.tap()
        email.typeText("Demo@mail.com")
        
        password.tap()
        password.typeText("qaz123")
        // Assert
        XCTAssertTrue(loginButton.isEnabled, "sign Up Button is not enabled for user interactions")
    }
    
    func testLoginController_WhenTapDontHaveAccountButton_ShouldPresentSignUpController_AndTapAlreadyHaveAccountButton_ShouldBackLoginController() {
        // Act
        dontHaveAccountButton.tap()
        // Assert
        XCTAssertTrue(alreadyHaveAccountButton.waitForExistence(timeout:1), "alreadyHaveAccountButton was not presented when dontHaveAccountButton was tapped")
        // Act
        alreadyHaveAccountButton.tap()
        // Assert
        XCTAssertTrue(dontHaveAccountButton.waitForExistence(timeout:1), "dontHaveAccountButton was not presented when alreadyHaveAccountButton was tapped")
    }
}
