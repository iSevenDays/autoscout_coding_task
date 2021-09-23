//
//  FruitFeedResult.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import Foundation

/// Feed Result model is used by FruitClient
struct FruitFeedResult: Decodable {
	let fruits: [Fruit]
}
