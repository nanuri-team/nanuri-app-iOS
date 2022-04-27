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
}
