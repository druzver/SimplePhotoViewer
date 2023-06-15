//
//  DIContainer.swift
//  SimplePhotoViewer
//
//  Created by Vitaly on 15.06.2023.
//

import Foundation
import SimplePhotoNetwork

protocol DIContainer {
	
	var photoRepository: PhotoRepository { get }
	
	
}

class DIContainerImpl : DIContainer {
	
	lazy var photoRepository: PhotoRepository = {
//		return FakeRepository()
		return UnSplashPhotoRepository.shared
	}()
}


