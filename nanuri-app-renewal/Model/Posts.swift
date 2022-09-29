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

struct ResultInfo: Codable {
    var writer: String
    var writerAddress: String?
    var writerNickname: String?
    var participants: [String]
    var favoredBy: [String]
    var images: [String]
    var uuid: String
    var title: String
    var category: String?
    var image: String?
    var unitPrice: Int
    var quantity: Int
    var description: String
    var minParticipants: Int
    var maxParticipants: Int
    var numParticipants: Int
    var productUrl: String
    var tradeType: String?
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
        case favoredBy = "favored_by"
        case images
        case uuid
        case title
        case category
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
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        writer = (try? value.decode(String.self, forKey: .writer)) ?? ""
        writerAddress = (try? value.decode(String.self, forKey: .writerAddress)) ?? ""
        writerNickname = (try? value.decode(String.self, forKey: .writerNickname)) ?? ""
        participants = (try? value.decode([String].self, forKey: .participants)) ?? []
        favoredBy = (try? value.decode([String].self, forKey: .favoredBy)) ?? []
        images = (try? value.decode([String].self, forKey: .images)) ?? []
        uuid = (try? value.decode(String.self, forKey: .uuid)) ?? ""
        title = (try? value.decode(String.self, forKey: .title)) ?? ""
        category = (try? value.decode(String.self, forKey: .category)) ?? ""
        image = (try? value.decode(String.self, forKey: .image)) ?? ""
        unitPrice = (try? value.decode(Int.self, forKey: .unitPrice)) ?? 0
        quantity = (try? value.decode(Int.self, forKey: .quantity)) ?? 0
        description = (try? value.decode(String.self, forKey: .description)) ?? ""
        minParticipants = (try? value.decode(Int.self, forKey: .minParticipants)) ?? 0
        maxParticipants = (try? value.decode(Int.self, forKey: .maxParticipants)) ?? 0
        numParticipants = (try? value.decode(Int.self, forKey: .numParticipants)) ?? 0
        productUrl = (try? value.decode(String.self, forKey: .productUrl)) ?? ""
        tradeType = (try? value.decode(String.self, forKey: .tradeType)) ?? ""
        orderStatus = (try? value.decode(String.self, forKey: .orderStatus)) ?? ""
        isPublished = (try? value.decode(Bool.self, forKey: .isPublished)) ?? false
        publishedAt = (try? value.decode(String.self, forKey: .publishedAt)) ?? ""
        viewCount = (try? value.decode(Int.self, forKey: .viewCount)) ?? 0
        waitedFrom = (try? value.decode(String.self, forKey: .waitedFrom)) ?? ""
        waitedUntil = (try? value.decode(String.self, forKey: .waitedUntil)) ?? ""
        createdAt = (try? value.decode(String.self, forKey: .createdAt)) ?? ""
        updatedAt = (try? value.decode(String.self, forKey: .updatedAt)) ?? ""
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
