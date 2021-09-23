//
//  CombineAPI.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 23.09.2021.
//

import Foundation
import Combine

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
									queue: DispatchQueue = .global(qos: .default),
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

