//
//  ContentViewBusinessLogic.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 20.09.2021.
//

import Foundation

/// The class is responsible for managing ContentView data (displaying of fruits)
class ContentViewBusinessLogic {
	private(set) var contentViewData = ContentViewData()
	@InjectedSafe
	private var fruitManager: FruitManager
	
	/// Uses local data for UI representation of Fruits.
	private var useLocalData = false
	
	init() {
		setupObservers()
		reloadFruits()
	}
	
	private func setupObservers() {
		fruitManager.addObserver(observer: self)
	}
	
	/// Loads  fruits from local data or from fruitManager
	private func reloadFruits() {
		if useLocalData {
			self.contentViewData.fruits = fruitsDataViewModels
		} else {
			fruitManager.getFruits { [weak self] fruits in
				self?.contentViewData.fruits = fruits.compactMap({FruitViewModel(fruit: $0)})
			}
		}
	}
}
extension ContentViewBusinessLogic: FruitManagerObserver {
	func fruitManager(_: FruitManager, didCacheFruits fruits: [Fruit]) {
		guard !useLocalData else { return }
		reloadFruits()
	}
}
