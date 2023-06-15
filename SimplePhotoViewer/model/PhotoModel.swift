//
//  PhotoModel.swift
//  SimplePhotoViewer
//
//  Created by Vitaly on 15.06.2023.
//

import SwiftUI
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
