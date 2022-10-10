//
//  ddd.swift
//  Orcanaut
//
//  Created by Pavel Sergeev on 23.10.2022.
//

import Foundation

struct Token: Codable {
    var address: String
    var usdPrice: Float
    var name: String
    var symbol: String
    var amount: Float
    var fees: Float
}
