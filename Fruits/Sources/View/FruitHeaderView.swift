//
//  FruitHeaderView.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import SwiftUI

struct FruitHeaderView: View {
    
    var fruit: FruitViewModel
    @State private var isAnimatingImage: Bool = false
    
    var body: some View {
        ZStack {
            ImageWithURL(fruit.image)
                .scaledToFit()
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y:  8)
            .padding(.vertical, 20)
                .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
        } //: ZSTACK
        .frame(height: 440)
        .onAppear() {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimatingImage = true
            }
        }
    }
}

// MARK: = PREVIEW

struct FruitHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FruitHeaderView(fruit: fruitsDataViewModels[0])
            .previewLayout(.fixed(width: 375, height: 440))
    }
}
