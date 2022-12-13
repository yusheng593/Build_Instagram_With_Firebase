//
//  ViewControllerTest.swift
//  Build_Instagram_With_FirebaseTests
//
//  Created by yusheng Lu on 2022/12/13.
//

import XCTest
@testable import Build_Instagram_With_Firebase

class ViewControllerTest: XCTestCase {
    
    var sut: ViewController!
    var emailTextField: UITextField!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var plusPhotoButton: UIButton!
    var signUpButton: UIButton!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ViewController()
        sut.loadViewIfNeeded()
        
        emailTextField = sut.emailTextField
        usernameTextField = sut.usernameTextField
        passwordTextField = sut.passwordTextField
        plusPhotoButton = sut.plusPhotoButton
        signUpButton = sut.signUpButton
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        emailTextField = nil
        usernameTextField = nil
        passwordTextField = nil
        plusPhotoButton = nil
        signUpButton = nil
    }

    func testViewController_WhenCreated_TextFieldsEmpty() throws {
        // Assert
        XCTAssertEqual(emailTextField.text, "", "Email text field was not empty when the view controller initially loaded")
        XCTAssertEqual(usernameTextField.text, "", "Username text field was not empty when the view controller initially loaded")
        XCTAssertEqual(passwordTextField.text, "", "Password text field was not empty when the view controller initially loaded")
    }
    
    func testViewController_WhenCreated_TextFieldsPlaceholder() throws {
        // Assert
        XCTAssertEqual(emailTextField.placeholder, K.emailPlaceholder, "Email text field has no placeholder")
        XCTAssertEqual(usernameTextField.placeholder, K.usernamePlaceholder, "Username text field has no placeholder")
        XCTAssertEqual(passwordTextField.placeholder, K.passwordPlaceholder, "Password text field has no placeholder")
    }
    
    func testViewController_WhenCreated_SignUpButtonTitle() throws {
        // Assert
        XCTAssertEqual(signUpButton.currentTitle, K.signButtonTitle, "Wrong title on sign up button")
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
