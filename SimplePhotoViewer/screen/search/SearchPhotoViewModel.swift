//
//  SearchPhotoViewModel.swift
//  SimplePhotoViewer
//
//  Created by Vitaly on 15.06.2023.
//

import SwiftUI
import SimplePhotoNetwork


@MainActor
class SearchPhotoViewModel : ObservableObject {
	
	@Published var items: [PhotoModel] = []
	@Published var loading = false
	@Published var errorMessage: String?
	
	private var _task: Task<Void, Never>? = nil
	private var repository: PhotoRepository
	
	var totalPages: Int = 0
	var currentPage: Int = 1
	var isResultEmpty: Bool = true
	var query: String = ""
	

	init(repository: PhotoRepository) {
		self.repository = repository
	}
	
	func setSearchText(query: String) {
		
		if query.count < 3 { return }
		
		_task?.cancel()
		
		self.query = query
		self.items = []
		errorMessage = nil
		
		self._task = Task() {
			isResultEmpty = false
			loading = true
			currentPage = 1
			var result: SearchResult
			
			do {
				let request = SearchPhotosRequest(
					query: query,
					page: currentPage,
					perPage: Constants.picturesPerPage
				)
				
				result = try await repository.search(request)
				
			} catch {
				errorMessage = "Some error. 👻"
				loading = false
				isResultEmpty = true
				self.items = []
				totalPages = 0
				return
			}
			
			if result.totalPages == 0 {
				isResultEmpty = true
			}
			
			self.items = result.results.map(PhotoModel.init)
			
			totalPages = result.totalPages
			
			loading = false
		}
		
		
	}
	
	func loadNextPage() {
		if loading { return }
		if currentPage >= Constants.maxPages { return }
		
		
		
		_task = Task {
			currentPage += 1
			loading = true
			let request = SearchPhotosRequest(
				query: query,
				page: currentPage,
				perPage: Constants.picturesPerPage
			)

			let result: SearchResult
			do {
				result = try await repository.search(request)
			} catch {
				//
				print("error", error.localizedDescription)
				return
			}

			if result.totalPages == 0 {
				isResultEmpty = true
			}

			let loadedItems = result.results.map(PhotoModel.init)

			items = items + loadedItems

			totalPages = result.totalPages
			loading = false

		}
		
		
		
	}
	
	
	func remove(item: PhotoModel) {
		guard let index = items.firstIndex(where: { item.id == $0.id }) else { return }
		items.remove(at: index)
	}
	
	func removeImage(at: IndexSet) {
		items.remove(atOffsets: at)
	}
}
