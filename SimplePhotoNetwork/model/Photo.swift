//
//  Photo.swift
//  SimplePhotoNetwork
//
//  Created by Vitaly on 15.06.2023.
//

import Foundation

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

