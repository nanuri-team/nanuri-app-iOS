//
//  SnsUserInfoSingleton.swift
//  nanuri-app-renewal
//
//  Created by a0000 on 2022/04/25.
//

import Foundation

class SnsUserInfoSingleton{
    static let shared = SnsUserInfoSingleton()
    
    var id: Int?
    var kakaoUserId:String?
    
    private init(){ }
}
