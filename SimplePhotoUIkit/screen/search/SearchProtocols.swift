//
//  SearchProtocols.swift
//  SimplePhotoUIkit
//
//  Created by Vitaly on 15.06.2023.
//

import Foundation


protocol SearchListRouterProtocol: AnyObject {
	
	func showPhoto(model: PhotoModel)
	
}


protocol SearchListViewProtocol : AnyObject {
	func updateList()
	func setLoading(isLoading: Bool)
}



@MainActor
protocol SearchListPresenterProtocol : AnyObject {
	
	var view: SearchListViewProtocol? {get set}
	var router: SearchListRouterProtocol? {get set}
	
	func tapOnPhoto(at: Int)
	func getItemsCount() -> Int
	func getItem(at index: Int) -> PhotoModel
	func onApear()
	func loadNextPage()
	func deleteItem(at index: Int)
	func clear()
	func setSearchText(query: String)
}

