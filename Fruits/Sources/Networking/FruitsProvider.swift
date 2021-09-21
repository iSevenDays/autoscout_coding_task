//
//  MoviesProvider.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import Foundation
import Combine
import CocoaLumberjackSwift

/// The class purpose is to update fruits array from the backend.
final class FruitsProvider: ObservableObject {
	
	// MARK:- Subscribers
	private var cancellable: AnyCancellable?
	
	// MARK:- Private properties
	private let client = FruitClient()
	
	@InjectedSafe
	private var fruitManager: FruitManager
	
	init() {
		
		cancellable = client.getFeed(.all)
			.sink(receiveCompletion: {
				// Here the actual subscriber is created
				DDLogDebug("completion: \($0)")
			},
			receiveValue: {
				DDLogDebug("Did download fruits: \($0.fruits)")
				self.fruitManager.cache(fruits: $0.fruits, completion: nil)
			})
	}
}
