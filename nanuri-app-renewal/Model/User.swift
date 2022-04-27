//
//  User.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import Foundation

struct User: Decodable {
    var user: UserData
}

struct UserInfo: Decodable {
    var user: [UserData]
}

struct UserData: Decodable {
    var socialID: Int
    
}


