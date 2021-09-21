//
//  SettingsRowView.swift
//  Fructus
//
//  Created by Anton Sokolchenko on 07.09.2021
//

import SwiftUI

struct SettingsRowView: View {
	
	// MARK: - PROPERTIES
	var name: String
	var content: String? = nil
	var linkLabel: String? = nil
	var linkDestination: String? = nil
	
	// MARK: - BODY
	
	var body: some View {
		VStack {
			Divider().padding(.vertical, 4)
			HStack {
				Text(name).foregroundColor(Color.gray)
				Spacer()
				if let content = content {
					Text(content)
				} else if let linkLabel = linkLabel,
									let linkDestination = linkDestination {
					Link(linkLabel, destination: URL(string: "https://\(linkDestination)")!)
					Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
				}
				else {
					EmptyView()
				}
			}
		}
	}
}

// MARK: - PREVIEW

struct SettingsRowView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			SettingsRowView(name: "Developer", content: "Anton Sokolchenko")
				.previewLayout(.fixed(width: 375, height: 60))
				.padding()
			SettingsRowView(name: "Website", linkLabel: "Anton Sokolchenko", linkDestination: "https://www.linkedin.com/in/sevendays/")
				.preferredColorScheme(.dark)
				.previewLayout(.fixed(width: 375, height: 60))
				.padding()
		}
	}
}
