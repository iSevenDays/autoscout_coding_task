//
//  FruitRowView.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import SwiftUI

struct FruitRowView: View {
    
    // MARK: - PROPERTIES
    
    var fruit: FruitViewModel
    
    // MARK: - BODY
    
    var body: some View {
        HStack {
            ImageWithURL(fruit.image)
                .scaledToFit()
                .frame(width: 80, height: 80, alignment: .center)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 3, x: 2, y: 2)
               
                .cornerRadius(8)
			VStack(alignment: .leading, spacing: 5) {
				Text(fruit.name)
					.font(.title2)
					.fontWeight(.bold)
				FruitInfoView(fruit: fruit)
			}
        } //: HSTACK
    }
}

// MARK: - PREVIEW

struct FruitRowView_Previews: PreviewProvider {
    static var previews: some View {
        FruitRowView(fruit: fruitsDataViewModels[2])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
