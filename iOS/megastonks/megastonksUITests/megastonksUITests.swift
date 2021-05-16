//
//  megastonksUITests.swift
//  megastonksUITests
//
//  Created by Kingsley Okeke on 2021-05-16.
//

import XCTest

extension XCTestCase {

    func tapElementAndWaitForKeyboardToAppear(element: XCUIElement) {
        let keyboard = XCUIApplication().keyboards.element
        while (true) {
            element.tap()
            if keyboard.exists {
                break;
            }
            RunLoop.current.run(until: NSDate(timeIntervalSinceNow: 0.5) as Date)
        }
    }
}

class megastonksUITests: XCTestCase {
    
    
    
    override class func setUp() {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testHome() {
        
        sleep(5)
        snapshot("WatchlistView")
        
        let tabBar = XCUIApplication().tabBars["Tab Bar"]
        tabBar.buttons["News Feed"].tap()
        sleep(5)
        snapshot("NewsFeed")
        tabBar.buttons["Portfolio"].tap()
        sleep(5)
        snapshot("Portfolio")
        tabBar.buttons["Account"].tap()
        sleep(5)
        snapshot("Account")
        
    }
}
