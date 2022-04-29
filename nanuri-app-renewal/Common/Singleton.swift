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
    var userToken: String = "a37f227eac7ea2e61e41ab32876d58409cf40a53"

    var isSettingLocation = false
    
    var testLocation: String = ""
    
    private init() { }
}
