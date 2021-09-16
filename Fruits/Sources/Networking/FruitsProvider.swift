//
//  MoviesProvider.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import Foundation
import Combine

/// Anton Sokolchenko note to developers: The class purpose is to provide fruits array.
/// In real-world scenario, I would have a separate class for downloading fruits and caching the in the database(Realm, CoreData).
/// Then, I would have a service to retrieve the entities from the database.
/// UI would call Business Logic services responsible for managing of the UI, Business Logic services will work with regular Services to fetch the data using Cache services.
/// And the data will be downloaded by a separate service that makes sure the data is up to date with the backend. They will follow SOLID principe - every service does one job.
final class FruitsProvider: ObservableObject {
	
	// MARK:- Subscribers
	private var cancellable: AnyCancellable?
	
	// MARK:- Publishers
	@Published var fruits: [FruitViewModel] = []
	
	// MARK:- Private properties
	private let client = FruitClient()
	
	init() {
		
		cancellable = client.getFeed(.all)
			.sink(receiveCompletion: {
				// Here the actual subscriber is created
				print ("completion: \($0)")
			},
			receiveValue: {
				self.fruits = $0.fruits.map { FruitViewModel(fruit: $0) }
			})
	}
}
