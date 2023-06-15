//
//  SearchResult.swift
//  SimplePhotoNetwork
//
//  Created by Vitaly on 15.06.2023.
//

import Foundation

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
