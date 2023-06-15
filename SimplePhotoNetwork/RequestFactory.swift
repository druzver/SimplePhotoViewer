//
//  RequestFactory.swift
//  SimplePhotoNetwork
//
//  Created by Vitaly on 15.06.2023.
//

import Foundation


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
		guard var components = URLComponents(string: host + path) else {
			throw ImageRepositoryError.unknown("wrong url")
		}
		
		components.queryItems = parameters.map() { key, value in
			URLQueryItem(name: key, value: value)
		}
		
		guard let url = components.url else {
			throw ImageRepositoryError.unknown("wrong url")
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		
		headers.forEach { key , value in
			request.setValue(value , forHTTPHeaderField: key)
		}
		
		do {
			try Task.checkCancellation()
			let (data, _) = try await session.data(for: request)
			try Task.checkCancellation()
			return try jsonDecoder.decode(T.self, from: data)
			
		} catch {
			
			//log error
			throw error
		}
		
	}
	
	
	
	
}
