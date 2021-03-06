//
//  FruitDetailView.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import SwiftUI

struct FruitDetailView: View {
	var fruit: FruitViewModel
	
	var body: some View {
		NavigationView {
			ScrollView(.vertical, showsIndicators: false) {
				VStack(alignment: .center, spacing: 20) {
					FruitHeaderView(fruit: fruit)
					
					VStack(alignment: .leading, spacing: 20) {
						Text(fruit.name)
							.font(.largeTitle)
							.fontWeight(.heavy)
						
						FruitInfoView(fruit: fruit)
						
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
