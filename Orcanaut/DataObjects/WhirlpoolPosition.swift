//
//  WhirlpoolPosition.swift
//  Orcanaut
//
//  Created by Pavel Sergeev on 23.10.2022.
//

import Foundation

struct WhirlpoolPosition: Codable {
    var positionAddress: String
    var lower: String
    var upper: String
    var inRange: Bool
    var price: Float
    var balance: String
    var rewards: String
    var tokenA: Token
    var tokenB: Token
}
