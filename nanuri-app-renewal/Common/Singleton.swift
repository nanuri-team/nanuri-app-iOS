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
    var userToken: String = "16d343db37d4a85cc9e3e764ec5e533dad6bc4a9"
    var uuid: String = "c4efed4c79d3bdd3155cba4fecd29eeb14ef5bf1"
    var isSettingLocation = false
    
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
