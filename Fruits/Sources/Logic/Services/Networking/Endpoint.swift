//
//  Endpoint.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import Foundation

protocol Endpoint {
	
	var base: String { get }
	var path: String { get }
}
extension Endpoint {
	var apiKey: String {
		// Let's pretend that for this example we support API key that is static (never expires)
		return "api_key=insert_api_key"
	}
	
	var urlComponents: URLComponents {
		var components = URLComponents(string: base)!
		components.path = path
		components.query = apiKey
		return components
	}
	
	var request: URLRequest {
		let url = urlComponents.url!
		return URLRequest(url: url)
	}
}
