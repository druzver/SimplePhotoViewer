//
//  PhotoModel.swift
//  SimplePhotoUIkit
//
//  Created by Vitaly on 15.06.2023.
//

import Foundation
import SimplePhotoNetwork


struct PhotoModel : Identifiable {
	var id: String = UUID().uuidString
	var thumb: String
	var largeImage: String
}

extension PhotoModel {
	
	init(photo: SimplePhotoNetwork.Photo) {
		self.id = photo.id
		self.thumb = photo.urls.thumb
		self.largeImage = photo.urls.small
	}
}
