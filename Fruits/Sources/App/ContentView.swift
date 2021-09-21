//
//  ContentView.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import SwiftUI


/// The class purpose is to display main view of the application
struct ContentView: View {
	
	// MARK: - PROPERTIES
	
	@State private var isShowingSettings: Bool = false
	
	@ObservedObject var contentViewData: ContentViewData
	
	// MARK: - BODY
	
	var body: some View {
		NavigationView {
			List {
				ForEach(contentViewData.fruits) { item in
					NavigationLink(destination: FruitDetailView(fruit: item)) {
						FruitRowView(fruit: item)
							.padding(.vertical, 4)
					}
				}
			}
			.navigationTitle(L10n.Main.View.Navigation.title)
			.navigationBarItems(trailing: Button(action: {
				isShowingSettings = true
			}) {
				Image(systemName: "gearshape")
			} //: BUTTON
			.sheet(isPresented: $isShowingSettings) {
				SettingsView()
			}
			)
		} //: NAVIGATION
		.navigationViewStyle(StackNavigationViewStyle())
	}
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
	static var previewData: ContentViewData {
		let data = ContentViewData()
		data.fruits = fruitsData.compactMap({FruitViewModel(fruit: $0)})
		return data
	}
	static var previews: some View {
		ContentView(contentViewData: self.previewData)
			.previewDevice("iPhone 11 Pro")
	}
}
