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


