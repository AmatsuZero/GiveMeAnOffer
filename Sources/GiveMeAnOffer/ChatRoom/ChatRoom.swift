//
//  ChatRoom.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/1.
//

import Foundation
import CoreFoundation

// https://www.raywenderlich.com/537-real-time-communication-with-streams-tutorial-for-ios
public protocol ChatRoomDelegate: class {
    func receivedMessage(message: Message)
}

public class ChatRoom: NSObject {
    
    var inputStream: InputStream?
    var outputStream: OutputStream?
    var username = ""
    
    let maxReadLength = 4096
    
    weak var delegate: ChatRoomDelegate?
    
    public func setup(address: String = "localhost", port: UInt32 = 80)  {

        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?

        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
                                           address as! CFString,
                                           port,
                                           &readStream,
                                           &writeStream)
        
        inputStream = readStream?.takeRetainedValue() as? InputStream
        inputStream?.delegate = self
        outputStream = writeStream?.takeRetainedValue() as? OutputStream
        
        inputStream?.schedule(in: .current, forMode: .common)
        outputStream?.schedule(in: .current, forMode: .common)
        
        inputStream?.open()
        outputStream?.open()
    }
    
    public func join(username: String) {
        guard let data = "iam:\(username)".data(using: .utf8) else {
            return
        }
        self.username = username
        _ = data.withUnsafeBytes { outputStream?.write($0, maxLength: data.count) }
        
    }
    
    public func sendText(message: String) {
        guard let data = "msg:\(message)".data(using: .utf8) else {
            return
        }
        _ = data.withUnsafeBytes { outputStream?.write($0, maxLength: data.count) }
    }
    
    public func stopChatSession() {
        inputStream?.close()
        outputStream?.close()
    }
}

extension ChatRoom: StreamDelegate {
    
    public func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .hasBytesAvailable where aStream is InputStream:
            readAvailableBytes(stream: aStream as! InputStream)
        case .endEncountered:
            stopChatSession()
        case .errorOccurred:
            stopChatSession()
        case .hasBytesAvailable:
            print("has space available")
        default:
            print("some other event...")
        }
    }
    
    
    private func readAvailableBytes(stream: InputStream) {
        
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)
        
        defer {
            buffer.deallocate()
        }
        
        while stream.hasBytesAvailable {
            let numberOfBytesRead = inputStream?.read(buffer, maxLength: maxReadLength) ?? -1
            if numberOfBytesRead < 0 {
                if let _ = stream.streamError {
                    break
                }
            }
            if let message = processedMessageString(buffer: buffer, length: numberOfBytesRead) {
                //Notify interested parties
                delegate?.receivedMessage(message: message)
            }
        }
    }
    
    private func processedMessageString(buffer: UnsafeMutablePointer<UInt8>,
                                        length: Int) -> Message? {
        guard let stringArray = String(bytesNoCopy: buffer,
                                       length: length,
                                       encoding: .utf8,
                                       freeWhenDone: true)?.components(separatedBy: ":"),
            let name = stringArray.first,
            let message = stringArray.last else {
                return nil
        }
        let messageSender: MessageSender = (name == self.username) ? .ourself : .someoneElse
        return Message(message: message, messageSender: messageSender, username: name)
    }
}
