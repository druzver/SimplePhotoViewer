//
//  MainPresenter.swift
//  SimplePhotoUIkit
//
//  Created by Vitaly on 15.06.2023.
//

import Foundation
import SimplePhotoNetwork


protocol MainRouterProtocol: AnyObject {
	
	func showPhoto(model: PhotoModel)
	
}

protocol MainViewProtocol : AnyObject {
	
	func updateList()
	
	func setLoading(isLoading: Bool)

}


@MainActor
protocol MainPresenterProtocol : AnyObject {
	
	var view: MainViewProtocol? {get set}
	var router: MainRouterProtocol? {get set}
	
	func tapOnPhoto(at: Int)
	func getItemsCount() -> Int
	func getItem(at index: Int) -> PhotoModel
	func onApear()
	func loadNextPage()
}



@MainActor
class MainPresenter : MainPresenterProtocol {
	
	weak var view: MainViewProtocol?
	weak var router: MainRouterProtocol?
	
	private var items: [PhotoModel] = []
	private var currentPage: Int = 1
	private let repository: PhotoRepository
	
	init(repository: PhotoRepository) {
		self.repository = repository
	}
	
	
	func onApear() {
		view?.setLoading(isLoading: true)
		
		Task {
			let photos = try await repository.getPhotos(.init(page: currentPage, perPage: Constants.picturesPerPage))
			items = photos.map({ PhotoModel.init(photo: $0) })
			
			view?.updateList()
			view?.setLoading(isLoading: false)
		}
		
	}


	
	func loadNextPage() {
		
		if currentPage >= Constants.maxPages {
			return
		}
		
		currentPage += 1
		
		Task {
			let photos = try await repository.getPhotos(.init(page: currentPage, perPage: Constants.picturesPerPage))
			items = items + photos.map({ PhotoModel.init(photo: $0) })
			
			view?.updateList()
			view?.setLoading(isLoading: false)
		}
	}
	
	
	func getItem(at index: Int) -> PhotoModel {
		return items[index]
	}
	
	
	func getItemsCount() -> Int {
		items.count
	}
	
	
	
	func tapOnPhoto(at index: Int) {
		let model = items[index]
		router?.showPhoto(model: model)
	}
	
	

	
}
