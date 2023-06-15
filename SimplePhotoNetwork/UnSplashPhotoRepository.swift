//
//  UnSplashPhotoRepository.swift
//  SimplePhotoNetwork
//
//  Created by Vitaly on 15.06.2023.
//

import Foundation

public class UnSplashPhotoRepository :  PhotoRepository {
		
	private var host = "https://api.unsplash.com"
	
	private var requestFactory: RequestFactory
	
	public init(clientId: String,  requestFactory: RequestFactory = DefaultRequestFactory()) {
		self.requestFactory = requestFactory
		self.requestFactory.host = host
		self.requestFactory.headers["Authorization"] = "Client-ID \(clientId)"
	}
	
	public func search(_ request: SearchPhotosRequest) async throws -> SearchResult {
		
		return try await requestFactory.requestGET("/search/photos", parameters: [
			"query": request.query,
			"page": "\(request.page)",
			"per_page": "\(request.perPage)",
		])
	}
	
	
	public func getPhotos(_ request: PhotosRequest) async throws -> [Photo] {
		return try await requestFactory.requestGET("/photos", parameters: [
			"page": "\(request.page)",
			"per_page": "\(request.perPage)",
			"order_by": "\(request.orderBy.rawValue)",
		])
	}
	
}

