//
//  ChatRoomTests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/7/1.
//

import XCTest
@testable import GiveMeAnOffer

class ChatRoomTests: XCTestCase {
    
    let chatRoom = ChatRoom()

    override func setUp() {
        chatRoom.join(username: "Daubert")
        chatRoom.delegate = self
    }

    override func tearDown() {
       chatRoom.stopChatSession()
    }

    func testSendText() {
         chatRoom.sendText(message: "Ay mang, wut's good?")
    }

    static var allTests = [
        ("Socket 聊天室", testSendText),
    ]
}

extension ChatRoomTests: ChatRoomDelegate {
    func receivedMessage(message: Message) {
        
    }
}
