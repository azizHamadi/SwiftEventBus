//
//  Message.swift
//  EventBus
//
//  Created by hamadi aziz on 01/03/2020.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import SwiftyJSON

/// Represents an EventBus message with metadata.
public class Message {
    let basis: JSON
    let eventBus: EventBus

    var headers: [String: String] {
        return (basis["headers"].dictionaryObject as! [String: String]?) ?? [String: String]()
    }

    init(basis: JSON, eventBus: EventBus) {
        self.basis = basis
        self.eventBus = eventBus
    }

    /// The body (content) of the message.
    public var body: JSON {
        return basis["body"]
    }

    /// True if this message was the result of a send (vs. publish)
    public var isSend: Bool {
        if let s = basis["send"].bool {

            return s
        }

        return false
    }
    
    /// Sends back a reply to this message
    ///
    /// - parameter body: the content of the message
    /// - parameter headers: headers to send with the message (default: `[String: String]()`)
    /// - parameter replyTimeout: the timeout (in ms) to wait for a reply if a reply callback is provided (default: `30000`)
    /// - parameter callback: the callback to handle the reply or timeout `Response` (default: `nil`)
    /// - throws: `EventBus.Error.invalidData(data:)` if the given `body` can't be converted to JSON
    /// - throws: `EventBus.Error.disconnected(cause:)` if not connected to the remote bridge
    public func reply(body: [String: Any],
                      headers: [String: String]? = nil,
                      replyTimeout: Int = 30000, // 30 seconds
                      callback: ((Response) -> ())? = nil) throws {
        if let replyAddress = self.basis["replyAddress"].string {
            try self.eventBus.send(to: replyAddress, body: body, headers: headers, replyTimeout: replyTimeout, callback: callback)
        }

    }
    
}
