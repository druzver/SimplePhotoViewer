//
//  SearchPhotosRequest.swift
//  SimplePhotoNetwork
//
//  Created by Vitaly on 15.06.2023.
//

import Foundation

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
