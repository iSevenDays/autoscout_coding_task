//
//  Observable.swift
//
//
//  Created by Anton Sokolchenko on 21/09/21.
//  Copyright © 2021 Anton Sokolchenko. All rights reserved.
//

import Foundation
import MulticastDelegateSwift_iOS

/// A general protocol for observable classes.
/// Usage:
/// 1 Add conformance to this protocol
/// 2 Add property var observers = MulticastDelegate<ObservableProtocol>()
protocol Observable {
	associatedtype ObserverProtocol
	var observers: MulticastDelegate<ObserverProtocol> { get }

	func addObserver(observer: ObserverProtocol)
}

extension Observable {
	func addObserver(observer: ObserverProtocol) {
		observers.addDelegate(observer)
	}
}
