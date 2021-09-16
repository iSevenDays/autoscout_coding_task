//
//  FruitFeed.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import Foundation

enum FruitFeed {
	case all
}
extension FruitFeed: Endpoint {
	
	var base: String {
		return "https://gist.githubusercontent.com"
	}
	
	var path: String {
		switch self {
		case .all: return "/gcbrueckmann/0484975ede56eeb7fba6e143aab7df0f/raw/edfb73c8ade674f40bfff8f3dfed97d327c1abc1/fruits.json"
		}
	}
}
