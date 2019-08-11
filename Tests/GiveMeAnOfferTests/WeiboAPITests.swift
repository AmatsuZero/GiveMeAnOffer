//
//  WeiboAPITests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/8/11.
//

import XCTest
@testable import GiveMeAnOffer

class WeiboAPITests: XCTestCase {
    
    override func setUp() {
        let env = ProcessInfo.processInfo.environment
        guard let clientId = env["AppKey"],
            let redirectURL = env["redirectURL"],
            let secret = env["AppSecret"] else {
            XCTFail("无法获取clientId和redirectURL")
            return
        }
        WeiboAPI.register(clientId: clientId, clientSecret: secret, redirectURL: redirectURL)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOauthAuthorize() {
        var api = WeiboAuthorize()
        api.state = "test"
        XCTAssertNotNil(WeiboAPI.shared.authorize(api))
    }
    
    func testAccessToken() {
        
        let expectation = self.expectation(description: "获取Token")
        let api = WeiboAuthorize()
        do {
            try WeiboAPI.shared.accessToken(api) { (error, token) in
                if let error = error {
                    XCTFail(error.localizedDescription)
                } else {
                    XCTAssertNotNil(token)
                }
                expectation.fulfill()
            }
        } catch {
            XCTFail(error.localizedDescription)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    static var allTests = [
        ("authorize接口", testOauthAuthorize),
        ("获取Token", testAccessToken)
    ]
}
