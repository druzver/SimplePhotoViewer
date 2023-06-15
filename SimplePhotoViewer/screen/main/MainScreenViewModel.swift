//
//  MainScreenViewModel.swift
//  SimplePhotoViewer
//
//  Created by Vitaly on 15.06.2023.
//

import SwiftUI
import SimplePhotoNetwork

@MainActor
class MainScreenViewModel : ObservableObject {
	
	@Published var items: [PhotoModel] = []
	@Published var loading = false
	@Published var searchText: String = ""
	
	private (set) var page: Int = 0
	private var repository: PhotoRepository
	
	var isLastPage: Bool {
		page >= Constants.maxPages
	}
	
	
	init(repository: PhotoRepository) {
		self.repository = repository
	}
	
	func loadFirstPage() {

		Task {
			page = 1
			loading = true
			
			let request = PhotosRequest(
				page: self.page,
				perPage: Constants.picturesPerPage
			)
			
			
			items = try await repository.getPhotos(request)
				.map(PhotoModel.init)
			
			loading = false
			
		}
	}
	
	func fetchNextPage() {
		if loading || page >= Constants.maxPages {
			return
		}
		

		Task {
			page += 1
			loading = true
			
			let request = PhotosRequest(
				page: self.page,
				perPage: Constants.picturesPerPage
			)
			
			let loadedItems = try await repository.getPhotos(request)
				.map(PhotoModel.init)
			
			
			items = items + loadedItems
			loading = false
			
		}
		
		
	}
	
	
	
	
}

