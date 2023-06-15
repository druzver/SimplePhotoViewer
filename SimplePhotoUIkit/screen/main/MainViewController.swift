//
//  ViewController.swift
//  SimplePhotoUIkit
//
//  Created by Vitaly on 15.06.2023.
//

import UIKit

class MainViewController: UIViewController {

	
	var presenter: MainPresenterProtocol?
	
	var searchListPresenter: SearchListPresenterProtocol?
	var searchListViewController: UIViewController?
	
	private lazy var  searchController: UISearchController = {
		UISearchController(searchResultsController: searchListViewController!)
	}()
	
	private lazy var contentView:  MainView = { MainView() }()
	
	override func loadView() {
		view = contentView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		
		contentView.collectionView.delegate = self
		contentView.collectionView.dataSource = self
		contentView.collectionView.register(PhotoImageCellView.self, forCellWithReuseIdentifier: "PhotoImageCellView")
		contentView.collectionView.showsVerticalScrollIndicator = false

		setupSearchBar()

		presenter?.onApear()

	}
	
	
	
	func setupSearchBar() {
		navigationItem.title = "Main"
		navigationItem.searchController = searchController
		
		searchController.searchBar.delegate = self
		searchController.delegate = self
		
		navigationItem.hidesSearchBarWhenScrolling = false
		definesPresentationContext = true
		navigationItem.largeTitleDisplayMode = .never
		

	}
	


}


extension MainViewController : UISearchControllerDelegate, UISearchBarDelegate {
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
		
		if text.count > 2 {
			DispatchQueue.main.async { [weak self] in
				self?.searchListPresenter?.setSearchText(query: text)
			}
			
		}
		
	}
		
	func didDismissSearchController(_ searchController: UISearchController) {
		searchListPresenter?.clear()

	}
	
}


extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		presenter?.tapOnPhoto(at: indexPath.item)
	}
	
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		let totalItems = (presenter?.getItemsCount() ?? 0)
		if (indexPath.item > totalItems - 3) {
			presenter?.loadNextPage()
		}
		
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return presenter?.getItemsCount() ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoImageCellView", for: indexPath) as! PhotoImageCellView
		
		if let model = presenter?.getItem(at: indexPath.item) {
			cell.setImage(url: model.thumb)
//			cell.labelView.text = model.id
		}
		
		
		return cell
	}
	
	
	
}



extension MainViewController : MainViewProtocol {
	
	func setLoading(isLoading: Bool) {
		//todo
	}
	
	
	func updateList() {
		contentView.collectionView.reloadData()
	}
}
