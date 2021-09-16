//
//  SettingsView.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import SwiftUI

struct SettingsView: View {
	// MARK: - PROPERTIES
	
	@Environment(\.presentationMode) var presentationMode
	
	// MARK: - BODY
	
	var body: some View {
		NavigationView {
			ScrollView(.vertical, showsIndicators: false) {
				VStack(spacing: 20) {
					// MARK: - SECTION 1
					GroupBox(label:
										SettingsLabelView(labelText: "Fructus", labelImage: "info.circle")
					) {
						Divider().padding(.vertical, 4)
						HStack(alignment: .center, spacing: 10) {
							Image("logo")
								.resizable()
								.scaledToFit()
								.frame(width: 80, height: 80)
								.cornerRadius(9)
							Text("If you want to eat healty food - eat fruits! They are low in fat, sodium, and calories. They don't have cholesterol. Fruits are sources of fiber, vitamins.")
								.font(.footnote)
						} //: HSTACK END
					}
					
				} //: VSTACK END
				.navigationBarTitle(Text("Settings"), displayMode: .large)
				.navigationBarItems(trailing: Button(action: {
					presentationMode.wrappedValue.dismiss()
				}) {
					Image(systemName: "xmark")
				}
				)
				.padding()
			} //: SCROLL
		} //: NAVIGATION
	}
}

// MARK: - PREVIEW

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView()
			.preferredColorScheme(.dark)
	}
}
