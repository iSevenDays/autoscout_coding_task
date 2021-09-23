//
//  ContentViewBusinessLogic.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 20.09.2021.
//

import Foundation
import Combine
import CocoaLumberjackSwift

/// The class is responsible for managing ContentView data (displaying of fruits)
class ContentViewBusinessLogic: ContentViewBusinessLogicProtocol {
	private(set) var contentViewData = ContentViewData()
	@InjectedSafe
	private var fruitManager: FruitManager
	
	// MARK:- Subscribers
	private var cancellable: AnyCancellable?
	
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
		cancellable?.cancel()
		cancellable = Future<[FruitViewModel], Never> { [weak self] promise in
			guard let self = self else { return }
			if self.useLocalData {
				promise(.success(fruitsDataViewModels))
			} else {
				self.fruitManager.getFruits { fruits in
					promise(.success(fruits.compactMap({FruitViewModel(fruit: $0)})))
				}
			}
		}
		.receive(on: RunLoop.main)
		.assign(to: \.fruits, on: contentViewData)
	}
}
extension ContentViewBusinessLogic: FruitManagerObserver {
	func fruitManager(_ fruitManager: FruitManager, didCacheFruits fruits: [Fruit]) {
		guard !useLocalData else { return }
		reloadFruits()
	}
}
