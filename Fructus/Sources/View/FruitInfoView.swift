//
//  FruitDetailView.swift
//  Fructus
//
//  Created by Anton Sokolchenko on 07.09.2021.
//


import Foundation
import SwiftUI

/// The class purpose is to display fruit details like price, weight
struct FruitInfoView: View {
	// MARK: - PROPERTIES
	
	var fruit: FruitViewModel
	
	// MARK: - BODY
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(fruit.price)
				.font(.headline)
				.foregroundColor(Color.secondary)
			if let weight = fruit.weight {
				Text(weight)
					.font(.headline)
					.foregroundColor(Color.secondary)
			}
		}
	}
}
// MARK: - PREVIEW

struct FruitInfoView_Previews: PreviewProvider {
	static var previews: some View {
		FruitInfoView(fruit: fruitsDataViewModels[2])
			.previewLayout(.sizeThatFits)
			.padding()
	}
}

