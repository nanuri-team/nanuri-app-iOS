//
//  GetUserLocation.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/09/29.
//

import Foundation

func splitLocation(location: String) -> (latitude: Double, longitude: Double) {
    let startIndex = location.index(location.startIndex, offsetBy: 17)
    let endIndex = location.index(before: location.endIndex)
    let splitLocation = location[startIndex ..< endIndex].components(separatedBy: " ")
    
    return (latitude: Double(splitLocation[0]) ?? 0.0, longitude: Double(splitLocation[1]) ?? 0.0)
}
