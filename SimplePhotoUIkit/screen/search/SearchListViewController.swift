//
//  SearchListViewController.swift
//  SimplePhotoUIkit
//
//  Created by Vitaly on 15.06.2023.
//

import UIKit


class SearchListViewController : UIViewController {
	
	private lazy var contentView:  SearchListView = { SearchListView() }()
	
	var presenter: SearchListPresenterProtocol?
	
	override func loadView() {
		view = contentView
	}
	
	override func viewDidLoad() {
		
		view.backgroundColor = .white
		
		contentView.collectionView.delegate = self
		contentView.collectionView.dataSource = self
		
		contentView.collectionView.register(PhotoImageCellView.self, forCellWithReuseIdentifier: "PhotoImageCellView")
		
		contentView.collectionView.showsVerticalScrollIndicator = false
		contentView.svipeToDeleteAction = { [weak self] indexPath in
			
			self?.presenter?.deleteItem(at: indexPath.item)
			self?.contentView.collectionView.reloadItems(at: [indexPath] )
		}
		
		presenter?.onApear()
		
		
	}
	
	
}



extension SearchListViewController : SearchListViewProtocol {
	
	func setLoading(isLoading: Bool) {
		//
	}
	
	
	func updateList() {
		let count = presenter?.getItemsCount() ?? 0
		
		contentView.collectionView.reloadData()
		
		contentView.emptyView.isHidden = count > 0
		
	}
	
	
	
}



extension SearchListViewController : UICollectionViewDataSource, UICollectionViewDelegate {
	
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
		
		cell.contentView.layoutMargins = .init(top: 0, left: 10, bottom: 10, right: 10)
		
		if let model = presenter?.getItem(at: indexPath.item) {
			cell.deleteButton.isHidden = false
			cell.setImage(url: model.largeImage)
			cell.onTapDelete = { [weak self] in
				self?.presenter?.deleteItem(at: indexPath.item)
				self?.contentView.collectionView.reloadItems(at: [indexPath] )
			}
		}
		
		
		return cell
	}
	
	
	
	
}
