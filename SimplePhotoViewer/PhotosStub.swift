//
//  PhotosStub.swift
//  SimplePhotoViewer
//
//  Created by Vitaly on 15.06.2023.
//

import SwiftUI
import SimplePhotoNetwork


#if DEBUG

class PhotosStub {
	
	static var photos: [PhotoModel] = {
		do {
			let url = Bundle.main.url(forResource: "photos", withExtension: "json")!
			let data = try Data(contentsOf: url)
			
			let decoder = JSONDecoder()
			let  photos = try! decoder.decode([SimplePhotoNetwork.Photo].self, from: data)
			
			return photos.map() { PhotoModel(photo: $0)}
		} catch {
			print("Error")
			return []
		}
		
	}()
//
//	static let photos: [PhotoModel] = [
//		PhotoModel(
//			thumb: "https://images.unsplash.com/photo-1520453803296-c39eabe2dab4?crop=entropy\\u0026cs=tinysrgb\\u0026fit=max\\u0026fm=jpg\\u0026ixid=M3w2NzQwOXwwfDF8c2VhcmNofDJ8fGhlbGxvfGVufDB8fHx8MTY4NjY2ODEwMHww\\u0026ixlib=rb-4.0.3\\u0026q=80\\u0026w=200",
//			largeImage: "https://images.unsplash.com/photo-1520453803296-c39eabe2dab4?crop=entropy\\u0026cs=tinysrgb\\u0026fit=max\\u0026fm=jpg\\u0026ixid=M3w2NzQwOXwwfDF8c2VhcmNofDJ8fGhlbGxvfGVufDB8fHx8MTY4NjY2ODEwMHww\\u0026ixlib=rb-4.0.3\\u0026q=80\\u0026w=400"
//		),
//		PhotoModel(
//			thumb: "https://images.unsplash.com/photo-1520453803296-c39eabe2dab4?crop=entropy\\u0026cs=tinysrgb\\u0026fit=max\\u0026fm=jpg\\u0026ixid=M3w2NzQwOXwwfDF8c2VhcmNofDJ8fGhlbGxvfGVufDB8fHx8MTY4NjY2ODEwMHww\\u0026ixlib=rb-4.0.3\\u0026q=80\\u0026w=200",
//			largeImage: "https://images.unsplash.com/photo-1520453803296-c39eabe2dab4?crop=entropy\\u0026cs=tinysrgb\\u0026fit=max\\u0026fm=jpg\\u0026ixid=M3w2NzQwOXwwfDF8c2VhcmNofDJ8fGhlbGxvfGVufDB8fHx8MTY4NjY2ODEwMHww\\u0026ixlib=rb-4.0.3\\u0026q=80\\u0026w=400"
//		),
//		PhotoModel(
//			thumb: "https://images.unsplash.com/photo-1520453803296-c39eabe2dab4?crop=entropy\\u0026cs=tinysrgb\\u0026fit=max\\u0026fm=jpg\\u0026ixid=M3w2NzQwOXwwfDF8c2VhcmNofDJ8fGhlbGxvfGVufDB8fHx8MTY4NjY2ODEwMHww\\u0026ixlib=rb-4.0.3\\u0026q=80\\u0026w=200",
//			largeImage: "https://images.unsplash.com/photo-1520453803296-c39eabe2dab4?crop=entropy\\u0026cs=tinysrgb\\u0026fit=max\\u0026fm=jpg\\u0026ixid=M3w2NzQwOXwwfDF8c2VhcmNofDJ8fGhlbGxvfGVufDB8fHx8MTY4NjY2ODEwMHww\\u0026ixlib=rb-4.0.3\\u0026q=80\\u0026w=400"
//		),
//		PhotoModel(
//			thumb: "https://images.unsplash.com/photo-1520453803296-c39eabe2dab4?crop=entropy\\u0026cs=tinysrgb\\u0026fit=max\\u0026fm=jpg\\u0026ixid=M3w2NzQwOXwwfDF8c2VhcmNofDJ8fGhlbGxvfGVufDB8fHx8MTY4NjY2ODEwMHww\\u0026ixlib=rb-4.0.3\\u0026q=80\\u0026w=200",
//			largeImage: "https://images.unsplash.com/photo-1520453803296-c39eabe2dab4?crop=entropy\\u0026cs=tinysrgb\\u0026fit=max\\u0026fm=jpg\\u0026ixid=M3w2NzQwOXwwfDF8c2VhcmNofDJ8fGhlbGxvfGVufDB8fHx8MTY4NjY2ODEwMHww\\u0026ixlib=rb-4.0.3\\u0026q=80\\u0026w=400"
//		),
//		PhotoModel(
//			thumb: "https://images.unsplash.com/photo-1520453803296-c39eabe2dab4?crop=entropy\\u0026cs=tinysrgb\\u0026fit=max\\u0026fm=jpg\\u0026ixid=M3w2NzQwOXwwfDF8c2VhcmNofDJ8fGhlbGxvfGVufDB8fHx8MTY4NjY2ODEwMHww\\u0026ixlib=rb-4.0.3\\u0026q=80\\u0026w=200",
//			largeImage: "https://images.unsplash.com/photo-1520453803296-c39eabe2dab4?crop=entropy\\u0026cs=tinysrgb\\u0026fit=max\\u0026fm=jpg\\u0026ixid=M3w2NzQwOXwwfDF8c2VhcmNofDJ8fGhlbGxvfGVufDB8fHx8MTY4NjY2ODEwMHww\\u0026ixlib=rb-4.0.3\\u0026q=80\\u0026w=400"
//		)
//	]
//
//
//
	
	
	
	
}







struct PreviewDebugViewModifier: ViewModifier {
	
	func body(content: Content) -> some View {
		content
			.environmentObject(ScreensFactory())
	}
}

extension View {
	
	func previewEnviroments() -> some View {
		self.modifier(
			PreviewDebugViewModifier()
		)
	}
}


class FakeRepository : PhotoRepository {
	
	static let shared = FakeRepository()
	
	
	func search(_ request: SimplePhotoNetwork.SearchPhotosRequest) async throws -> SimplePhotoNetwork.SearchResult {
		
		let url = Bundle.main.url(forResource: "photos_search", withExtension: "json")!
		let data = try Data(contentsOf: url)
		
		let decoder = JSONDecoder()
		return try decoder.decode(SimplePhotoNetwork.SearchResult.self, from: data)
		
	}
	
	func getPhotos(_ request: SimplePhotoNetwork.PhotosRequest) async throws -> [SimplePhotoNetwork.Photo] {
		
		let url = Bundle.main.url(forResource: "photos", withExtension: "json")!
		let data = try Data(contentsOf: url)
		
		let decoder = JSONDecoder()
		return try decoder.decode([SimplePhotoNetwork.Photo].self, from: data)
		
	}

	
	
}




#endif


