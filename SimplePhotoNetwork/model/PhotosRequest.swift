//
//  PhotosRequest.swift
//  SimplePhotoNetwork
//
//  Created by Vitaly on 15.06.2023.
//

import Foundation



public struct PhotosRequest {
	
	public enum SortOrder: String {
		 case latest
		 case oldest
		 case popular
	 }

	
	
	public var page: Int
	public var perPage: Int
	public var orderBy:SortOrder
	
	public init(page: Int = 1, perPage: Int = 10, orderBy: SortOrder = .latest) {
		self.page = page
		self.perPage = perPage
		self.orderBy = orderBy
	}
	
}


