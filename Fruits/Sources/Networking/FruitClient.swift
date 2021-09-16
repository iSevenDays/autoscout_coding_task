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
	
	// 1
	let session: URLSession
	
	// 2
	init(configuration: URLSessionConfiguration) {
		self.session = URLSession(configuration: configuration)
	}
	
	convenience init() {
		self.init(configuration: .default)
	}
	
	// 3
	func getFeed(_ feedKind: FruitFeed) -> AnyPublisher<FruitFeedResult, Error> {
		execute(feedKind.request, decodingType: FruitFeedResult.self, retries: 2)
	}
}

protocol CombineAPI {
	var session: URLSession { get }
	func execute<T>(_ request: URLRequest,
									decodingType: T.Type,
									queue: DispatchQueue,
									retries: Int) -> AnyPublisher<T, Error> where T: Decodable
}

extension CombineAPI {
	
	func execute<T>(_ request: URLRequest,
									decodingType: T.Type,
									queue: DispatchQueue = .main,
									retries: Int = 0) -> AnyPublisher<T, Error> where T: Decodable {
		
		return session.dataTaskPublisher(for: request)
			.tryMap {
				guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
					// Anton Sokolchenko: Additionally, there are 201 and other possible statuses, but we will not handle them in this example project
					throw APIError.responseUnsuccessful
				}
				return $0.data
			}
			.decode(type: T.self, decoder: JSONDecoder())
			.receive(on: queue)
			.retry(retries)
			.eraseToAnyPublisher()
	}
}

