//
//  Response.swift
//  EventBus
//
//  Created by hamadi aziz on 01/03/2020.
//  Copyright © 2020 hamadi aziz. All rights reserved.
//

import Foundation

/// Represents the response for a reply.
public struct Response {
    /// The message for the reply.
    ///
    /// Will be nil if `timedOut` is `true`
    public let message: Message?
    
    /// The timeout status of the reply.
    ///
    /// `message` will be nil if this is `true`.
    public var timedOut: Bool {
        if let _ = self.message {

            return false
        }

        return true
    }

    static func timeout() -> Response {
        return Response(message: nil)
    }
}
