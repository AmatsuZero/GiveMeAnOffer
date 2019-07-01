//
//  Message.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/1.
//

import Foundation

public enum MessageSender {
    case ourself
    case someoneElse
}

public struct Message {
    public let message: String
    public let senderUsername: String
    public let messageSender: MessageSender
    
    init(message: String, messageSender: MessageSender, username: String) {
        self.message = message.withoutWhitespace()
        self.messageSender = messageSender
        self.senderUsername = username
    }
}

extension String {
    func withoutWhitespace() -> String {
        return replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: "\0", with: "")
    }
}
