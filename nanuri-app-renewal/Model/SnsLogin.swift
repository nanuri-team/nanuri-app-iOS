//
//  SnsLogin.swift
//  nanuri-app
//
//  Created by a0000 on 2021/12/28.
//

import Foundation

struct SocialLogin: Codable {
    let token: String
    let type: String
    let uuid: String
}

extension Decodable {
    static func decode<T: Decodable>(dictionary: [String: String]) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [.fragmentsAllowed])
        return try JSONDecoder().decode(T.self, from: data)
    }
}



struct SNSPostResponse: Decodable {
    var data: SnsId
}

struct SnsId: Decodable {
    var user: String
    var kakaoID: Int
    var createdAt: String
    var updatedAt: String
    
    enum CodingKeys:String, CodingKey {
        case user
        case kakaoID = "kakao_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    // nil 생성자 재정의
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user = (try? values.decodeIfPresent(String.self, forKey: .user)) ?? ""
        kakaoID = (try? values.decodeIfPresent(Int.self, forKey: .kakaoID)) ?? 0
        createdAt = try values.decode(String.self, forKey: .createdAt)
        updatedAt = try values.decode(String.self, forKey: .updatedAt)
    }
}



