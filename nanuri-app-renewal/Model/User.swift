//
//  User.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import Foundation

struct UserInfo: Codable {
    var posts: [String]
    var favoritePosts: [String]
    var lastLogin: String
    var uuid: String
    var email: String
    var nickName: String
    var isActive: Bool
    var isAdmin: Bool
    var latitude: Int
    var longitude: Int
    var address: String
    var profile: String
    var authProvider: String
    var createdAt: String
    var updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case posts, uuid, email, latitude, longitude, address, profile
        case favoritePosts = "favorite_posts"
        case lastLogin = "last_login"
        case nickName = "nickname"
        case isActive = "is_active"
        case isAdmin = "is_admin"
        case authProvider = "auth_provider"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        posts = (try? values.decode([String].self, forKey: .posts)) ?? []
        favoritePosts = (try? values.decode([String].self, forKey: .favoritePosts)) ?? []
        lastLogin = (try? values.decode(String.self, forKey: .lastLogin)) ?? ""
        uuid = (try? values.decode(String.self, forKey: .uuid)) ?? ""
        email = (try? values.decode(String.self, forKey: .email)) ?? ""
        nickName = (try? values.decode(String.self, forKey: .nickName)) ?? ""
        isActive = (try? values.decode(Bool.self, forKey: .isActive)) ?? false
        isAdmin = (try? values.decode(Bool.self, forKey: .isAdmin)) ?? false
        latitude = (try? values.decode(Int.self, forKey: .latitude)) ?? 0
        longitude = (try? values.decode(Int.self, forKey: .longitude)) ?? 0
        address = (try? values.decode(String.self, forKey: .address)) ?? ""
        profile = (try? values.decode(String.self, forKey: .profile)) ?? ""
        authProvider = (try? values.decode(String.self, forKey: .authProvider)) ?? ""
        createdAt = (try? values.decode(String.self, forKey: .createdAt)) ?? ""
        updatedAt = (try? values.decode(String.self, forKey: .updatedAt)) ?? ""
    }
}

struct UserResult: Codable {
    let count: Int
    let next: Int?
    let previous: Int?
    let result: [UserInfo]?
}
