//
//  Singleton.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/27.
//

import Foundation

class Singleton {
    static let shared = Singleton()
    
    var tokenType: String = "Token"
    var userToken: String = ""
    var uuid: String = ""
    
    var testLocation: String = ""
    
    private init() { }
}

//class UserSingleton {
//    static let shared = UserSingleton()
////    var uuid: String
//    var userData: User?
//
//    private init() {}
//
//}
