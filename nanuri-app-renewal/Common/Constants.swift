//z
//  Enum.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import Foundation
import UIKit

let ratioHeight = UIScreen.main.bounds.height / 812
let ratioWidth = UIScreen.main.bounds.width / 375

enum APIInfo {
    static let hostURL = "https://nanuri.app/"
    static let api = "api/"
    static let version = "v1/"
}

enum APIList {
    static let user = "users/"
    static let posts = "posts/"
}


enum DeliveryTypeName {
    static let delivery = "배송"
    static let direct = "직거래"
}

enum LevelTypeName {
    static let been = "콩"
    static let leaf = "새싹"
    static let flower = "꽃"
    static let tree = "나무"
}

enum ChatType {
    static let loadMessage = "load_messages"
    static let sendMessage = "send_message"
}

//enum TradeType {
//    case direct = "DIRECT"
//    case parcel = "PARCEL"
//}
//
//enum OrderStatus {
//    case waiting = "WAITING"
//}
//
