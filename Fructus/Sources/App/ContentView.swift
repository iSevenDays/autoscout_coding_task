//
//  ContentView.swift
//  Fructus
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import SwiftUI


/// The class purpose is to display main view of the application
struct ContentView: View {
    
    // MARK: - PROPERTIES
    
    @State private var isShowingSettings: Bool = false
	@State var useLocalData: Bool = false
    
	@StateObject private var fruitProvider = FruitsProvider()
	
	var fruits: [FruitViewModel] {
		if useLocalData {
			return fruitsDataViewModels
		}
		return fruitProvider.fruits
	}
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            List {
                ForEach(fruits) { item in
                    NavigationLink(destination: FruitDetailView(fruit: item)) {
                        FruitRowView(fruit: item)
                            .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Fruits")
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
    static var previews: some View {
        ContentView(useLocalData: true)
            .previewDevice("iPhone 11 Pro")
    }
}
