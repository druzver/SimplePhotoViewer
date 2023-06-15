//
//  PhotoRepository.swift
//  SimplePhotoNetwork
//
//  Created by Vitaly on 15.06.2023.
//

import Foundation



public protocol PhotoRepository {
	
	func search(_ request: SearchPhotosRequest) async throws -> SearchResult

	func getPhotos(_ request: PhotosRequest) async throws -> [Photo]

}



public enum ImageRepositoryError : Error {
	case unknown(String)
}

public enum SortOrder: String {
	case latest
	case oldest
	case popular
}


public struct PhotosRequest {
	
	public var page: Int
	public var perPage: Int
	public var orderBy:SortOrder
	
	public init(page: Int = 1, perPage: Int = 10, orderBy: SortOrder = .latest) {
		self.page = page
		self.perPage = perPage
		self.orderBy = orderBy
	}
	
}

public struct Photo : Codable {
	
	public let id: String
	
	public let urls: PhotoUrls
	
	public init(id: String, urls: PhotoUrls) {
		self.id = id
		self.urls = urls
	}
	
	
	public struct PhotoUrls : Codable {
		public var raw: String
		public var small: String
		public var thumb: String
		
		public init(raw: String, small: String, thumb: String) {
			self.raw = raw
			self.small = small
			self.thumb = thumb
		}
		
	}
	
}



public struct SearchPhotosRequest {
	public var query: String
	public var page: Int = 1
	public var perPage: Int = 10
	
	public init(query: String, page: Int = 1, perPage: Int = 10) {
		self.query = query
		self.page = page
		self.perPage = perPage
	}
}


public struct SearchResult : Codable {

	enum CodingKeys: String, CodingKey {
		case total
		case totalPages = "total_pages"
		case results
	}
	
	
	public var total: Int
	public var totalPages: Int
	public var results: [Photo]
	
	public init(total: Int, totalPages: Int, results: [Photo] ) {
		self.total = total
		self.totalPages = totalPages
		self.results = results
	}
	
}


public protocol RequestFactory {
	
	
	var host: String {get set}
	var headers: [String: String] { get set}
	
	func requestGET<T: Codable>(_ path: String, parameters: [String:String])  async throws -> T
	
}

public class DefaultRequestFactory : RequestFactory  {
	
	public var host: String = ""
	public var headers: [String: String] = [:]
	
	private var session: URLSession
	private let jsonDecoder:JSONDecoder
	
	public init(session: URLSession = .shared, jsonDecoder: JSONDecoder = JSONDecoder()) {
		self.session = session
		self.jsonDecoder = jsonDecoder
		
		self.headers["Accept"] = "application/json"
	}
	
	public func requestGET<T: Codable>(_ path: String, parameters: [String:String] = [:])  async throws -> T {
		guard var components = URLComponents(string: host + path) else { throw ImageRepositoryError.unknown("wrong url")}
		
		components.queryItems = parameters.map() { key, value in
			URLQueryItem(name: key, value: value)
		}
		
		var request = URLRequest(url: components.url!)
		request.httpMethod = "GET"
		
		headers.forEach { key , value in
			request.setValue(value , forHTTPHeaderField: key)
//			request.setValue("Client-ID \(clientId)", forHTTPHeaderField: "Authorization")
		}
		
//		request.setValue("Client-ID \(clientId)", forHTTPHeaderField: "Authorization")
//		request.setValue("application/json", forHTTPHeaderField: "Accept")
		
		do {
			try Task.checkCancellation()
			let (data, _) = try await session.data(for: request)
			try Task.checkCancellation()
//			if Task.isCancelled { return [] }
			return try jsonDecoder.decode(T.self, from: data)
			
			
		} catch {
			//log error
			throw error
		}
		
	}
	
	
	
	
}

public class UnSplashPhotoRepository :  PhotoRepository {
	
	public static let shared = UnSplashPhotoRepository(clientId: "4c9fbfbbd92c17a2e95081cec370b4511659666240eb4db9416c40c641ee843b")
	
//	private var clientId = "4c9fbfbbd92c17a2e95081cec370b4511659666240eb4db9416c40c641ee843b"
	private var host = "https://api.unsplash.com"
	
//	private var session = URLSession.shared
	
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
	
//
//	private func request<T: Codable>(_ path: String, parameters: [String:String] = [:])  async throws -> T {
//		guard var components = URLComponents(string: host + path) else { throw ImageRepositoryError.unknown("wrong url")}
//
//		components.queryItems = parameters.map() { key, value in
//			URLQueryItem(name: key, value: value)
//		}
////		[
////			URLQueryItem(name: "page", value: "\(request.page)"),
////			URLQueryItem(name: "per_page", value: "\(request.perPage)"),
////			URLQueryItem(name: "order_by", value: request.orderBy.rawValue),
////		]
//
//		var request = URLRequest(url: components.url!)
//		request.httpMethod = "GET"
//		request.setValue("Client-ID \(clientId)", forHTTPHeaderField: "Authorization")
//		request.setValue("application/json", forHTTPHeaderField: "Accept")
//
//		do {
//			let (data, _) = try await session.data(for: request)
////			if Task.isCancelled { return [] }
//			return try jsonDecoder.decode(T.self, from: data)
//
//
//		} catch {
//			//log error
//			throw error
//		}
//
//	}
//
//
//
	
	
}

