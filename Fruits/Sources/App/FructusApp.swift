//
//  FruitsApp.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import SwiftUI

@main
struct FruitsApp: App {
	// DependenciesBuilder must be initialized before any injected dependencies are being used
	let dependencyBuilder = DependenciesBuilder()
	
	@InjectedAlways
	private var contentViewBusinessLogic: ContentViewBusinessLogic
	
	var body: some Scene {
		WindowGroup {
			ContentView(contentViewData: contentViewBusinessLogic.contentViewData)
		}
	}
}
