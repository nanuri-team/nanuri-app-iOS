//
//  Posts.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/27.
//

import Foundation

struct PostList: Decodable {
    var count: Int
    var next: String?
    var pervious: String?
    var results: [ResultInfo]
}

struct ResultInfo: Decodable {
    var writer: String
    var writerAddress: String?
    var writerNickname: String?
    var participants: [String]
    var category: String?
    var favoredBy: [String]
    var uuid: String
    var title: String
    var image: String?
    var unitPrice: Int
    var quantity: Int
    var description: String
    var minParticipants: Int
    var maxParticipants: Int
    var numParticipants: Int
    var productUrl: String
    var tradeType: String
    var orderStatus: String
    var isPublished: Bool
    var publishedAt: String?
    var viewCount: Int
    var waitedFrom: String?
    var waitedUntil: String?
    var createdAt: String
    var updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case writer
        case writerAddress = "writer_address"
        case writerNickname = "writer_nickname"
        case participants
        case category
        case favoredBy = "favored_by"
        case uuid
        case title
        case image
        case unitPrice = "unit_price"
        case quantity
        case description
        case minParticipants = "min_participants"
        case maxParticipants = "max_participants"
        case numParticipants = "num_participants"
        case productUrl = "product_url"
        case tradeType = "trade_type"
        case orderStatus = "order_status"
        case isPublished = "is_published"
        case publishedAt = "published_at"
        case viewCount = "view_count"
        case waitedFrom = "waited_from"
        case waitedUntil = "waited_until"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct postProductInfo {
    var quantity: String = ""
    var description: String = ""
    var minParticipants: Int = 0
    var maxParticipants: Int = 0
    var numParticipants: Int = 0
    var productUrl: String = ""
    var tradeType: String = ""
    var orderStatus: String = ""
    var waitedFrom: String = ""
    var waitedUntil: String = ""
    var title: String = ""
    var image: String = ""
    var unitPrice: Int = 0
    var category: String = ""
}
