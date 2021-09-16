//
//  ImageWithURL.swift
//  Fructus
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import Foundation
import SwiftUI

// The class purpose is to replace SwiftUI Image class to support showing both local and remote images. Remote images will be cached
struct ImageWithURL: View {
	
	@ObservedObject var imageLoader: ImageLoaderAndCache
	private var url: String

	init(_ url: String) {
		imageLoader = ImageLoaderAndCache(imageURL: url)
		self.url = url
	}

	var body: some View {
		// in iOS 15 , SwiftUI has a dedicated AsyncImage, but let's support Xcode 12
		// we support both local and remote image URLs
		Image(uiImage: UIImage(named: self.url) ?? UIImage(data: self.imageLoader.imageData) ?? UIImage())
			.resizable()
			.renderingMode(.original)
			.clipped()
	}
}

class ImageLoaderAndCache: ObservableObject {
	
	@Published var imageData = Data()
	
	init(imageURL: String) {
		let cache = URLCache.shared
		let request = URLRequest(url: URL(string: imageURL)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 30.0)
		if let data = cache.cachedResponse(for: request)?.data {
			// Anton Sokolchenko: for logging I would use CocoaLumberjackSwift
			print("Got image from cache for url: \(imageURL)")
			self.imageData = data
		} else {
			URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
				if let data = data, let response = response {
				let cachedData = CachedURLResponse(response: response, data: data)
									cache.storeCachedResponse(cachedData, for: request)
					DispatchQueue.main.async {
						// Anton Sokolchenko: for logging I would use CocoaLumberjackSwift
						print("downloaded from internet \(imageURL)")
						self.imageData = data
					}
				}
			}).resume()
		}
	}
}

// MARK: - PREVIEW

struct ImageWithURL_Previews: PreviewProvider {
	static var previews: some View {
		ImageWithURL(fruitsDataViewModels[2].image)
			.previewLayout(.fixed(width: 300, height: 300))
			.padding()
		ImageWithURL("https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Red_Apple.jpg/265px-Red_Apple.jpg")
			.previewLayout(.fixed(width: 300, height: 300))
			.padding()
	}
}

