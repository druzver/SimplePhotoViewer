//
//  PhotoRepository.swift
//  SimplePhotoNetwork
//
//  Created by Vitaly on 15.06.2023.
//

import Foundation



public enum ImageRepositoryError : Error {
	case unknown(String)
}


public protocol PhotoRepository {
	
	func search(_ request: SearchPhotosRequest) async throws -> SearchResult

	func getPhotos(_ request: PhotosRequest) async throws -> [Photo]

}
