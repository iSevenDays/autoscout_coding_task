//
//  FruitClient.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import Foundation
import Combine

/// The class purpose is to provide methods for getting fruits
/// Normally, I use AFNetworking and Generics class that supports decoding from JSON -> swift structs/classes using a custom protocol
/// For this example, I implemented Combine API client. Both methods are fine if they have the same results.
class FruitClient: CombineAPI {
	
	let session: URLSession
	
	init(configuration: URLSessionConfiguration) {
		self.session = URLSession(configuration: configuration)
	}
	
	convenience init() {
		self.init(configuration: .default)
	}
	
	func getFeed(_ feedKind: FruitFeed) -> AnyPublisher<FruitFeedResult, Error> {
		execute(feedKind.request, decodingType: FruitFeedResult.self, retries: 2)
	}
}
