//
//  Chat.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/28.
//

import Foundation

struct SendChatResponse: Codable {
    var type = "load_message"
    var message = ""
}

struct ChatResponse {
    var message: String
    var sender: String
    var createdAt: String
}

struct LoadChatResponse {
    var channelId: String
    var createdAt: String
    var message: String
    var messageFrom: String
    var messageId: String
    var messageTo: String
    
    enum CodingKeys: String, CodingKey {
        case channelId = "channel_id"
        case createdAt = "create_at"
        case messageFrom = "message_from"
        case messageId = "message_id"
        case messageTo = "message_to"
    }
}
