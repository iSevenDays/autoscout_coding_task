//
//  ContentViewData.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 20.09.2021.
//

import Foundation

final class ContentViewData: ObservableObject {
	@Published var fruits: [FruitViewModel] = []
}
