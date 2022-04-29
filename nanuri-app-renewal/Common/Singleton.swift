//
//  Singleton.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/27.
//

import Foundation

class Singleton {
    static let shared = Singleton()
    
    let tokenName: String = "Token"
    var userToken: String = "c698d104a7d8a9b5564ac9a141010d56c36ac02a"
    
    var uuid: String = "c4efed4c79d3bdd3155cba4fecd29eeb14ef5bf1"
    
}

//class UserSingleton {
//    static let shared = UserSingleton()
////    var uuid: String
//    var userData: User?
//
//    private init() {}
//
//}
