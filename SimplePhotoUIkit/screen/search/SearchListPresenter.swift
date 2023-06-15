//
//  SearchListPresenter.swift
//  SimplePhotoUIkit
//
//  Created by Vitaly on 15.06.2023.
//

import Foundation
import SimplePhotoNetwork



@MainActor
class  SearchListPresenter : SearchListPresenterProtocol {
	
	weak var view: SearchListViewProtocol?
	weak var router: SearchListRouterProtocol?

	
	private var searchText: String = ""
	private var items:[PhotoModel] = []
	private var currentPage: Int = 0
	private var totalPages: Int = 0
	
	private let repository: PhotoRepository
	
	init(repository: PhotoRepository) {
		self.repository = repository
	}

	func onApear() {
	}
	
	func clear() {
		items = []
		currentPage = 0
		totalPages = 0
		view?.updateList()
	}
	
	func deleteItem(at index: Int) {
		items.remove(at: index)
	}
	
	
	func setSearchText(query: String) {
		self.searchText = query
		
		Task {
			
			currentPage = 1
			let result = try await repository.search(.init( query: searchText, page: currentPage, perPage: Constants.picturesPerPage))
			items = result.results.map({ PhotoModel.init(photo: $0) })
			totalPages = result.totalPages
			
			view?.updateList()
			view?.setLoading(isLoading: false)
		}
	}
	
	
	func loadNextPage() {
		if currentPage >= totalPages { return }
		if currentPage >= Constants.maxPages { return }
		
		Task {
			currentPage += 1
			let photos = try await repository.getPhotos(.init(page: currentPage))
			items = items + photos.map({ PhotoModel.init(photo: $0) })
			
			view?.updateList()
			view?.setLoading(isLoading: false)
		}
	}
	
	func getItemsCount() -> Int {
		return items.count
	}
	
	func getItem(at index: Int) -> PhotoModel {
		return items[index]
	}
	
	func tapOnPhoto(at: Int) {
		let model = items[at]
		router?.showPhoto(model: model)
	}
	
}
