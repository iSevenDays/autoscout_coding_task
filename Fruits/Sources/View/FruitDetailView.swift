//
//  FruitDetailView.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import SwiftUI

struct FruitDetailView: View {
	// MARK: - PROPERTIES
	
	var fruit: FruitViewModel
	
	// MARK: - BODY
	
	var body: some View {
		NavigationView {
			ScrollView(.vertical, showsIndicators: false) {
				VStack(alignment: .center, spacing: 20) {
					// HEADER
					FruitHeaderView(fruit: fruit)
					
					VStack(alignment: .leading, spacing: 20) {
						// TITLE
						Text(fruit.name)
							.font(.largeTitle)
							.fontWeight(.heavy)
						
						// Info
						FruitInfoView(fruit: fruit)
						
						// LINK
						SourceLinkView()
							.padding(.top, 10)
							.padding(.bottom, 40)
						
					} //: VSTACK
					.padding(.horizontal, 20)
					.frame(maxWidth: 640, alignment: .center)
				} //: VSTACK
				.navigationBarTitle(fruit.name, displayMode: .inline)
				.navigationBarHidden(true)
			} //: SCROLL
			.edgesIgnoringSafeArea(.top)
		} //: NAVIGATION
		.navigationViewStyle(StackNavigationViewStyle())
	}
}

// MARK: - PREVIEW

struct FruitDetailView_Previews: PreviewProvider {
	static var previews: some View {
		FruitDetailView(fruit: fruitsDataViewModels[2])
			.previewDevice("iPhone 11 Pro")
	}
}
