//
//  User.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import Foundation

struct UserList: Decodable {
    var count: Int
    var next: String?
    var pervious: String?
    var results: [UserInfo]
}

//struct UserInfo: Decodable {
//    var user: [UserData]
//}
struct UserInfo: Decodable {
    var posts: [String]
    var favoritePosts: [String]
    var lastLogin: String
    var uuid: String
    var email: String
    var nickname: String?
    var isActive: Bool
    var isAdmin: Bool
    var latitude: Double?
    var longitude: Double?
    var address: String?
    var profile: String?
    var authProvider: String?
    var createdAt: String
    var updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case posts
        case favoritePosts = "favorite_posts"
        case lastLogin = "last_login"
        case uuid
        case email
        case nickname
        case isActive = "is_active"
        case isAdmin = "is_admin"
        case latitude
        case longitude
        case address
        case profile
        case authProvider = "auth_provider"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


struct UserPostResponse: Decodable {
    var results: UserInfo
}

