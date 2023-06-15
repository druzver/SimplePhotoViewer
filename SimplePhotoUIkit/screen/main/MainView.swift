//
//  MainView.swift
//  SimplePhotoUIkit
//
//  Created by Vitaly on 15.06.2023.
//

import UIKit



class MainView : BaseView {

	lazy var collectionLayout: UICollectionViewCompositionalLayout = {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .fractionalWidth(0.3) // .fractionalHeight(1.0)
		)
		
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension:  .fractionalWidth(0.3) // .fractionalWidth(1.0)
		)
		
		
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
		let spacing = CGFloat(5)
		group.interItemSpacing = .fixed(spacing)

		let section = NSCollectionLayoutSection(group: group)
		section.interGroupSpacing = spacing
		section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

		let layout = UICollectionViewCompositionalLayout(section: section)
		return layout

	}()
	
	
	lazy var  collectionView: UICollectionView = {
		let ret = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
		ret.translatesAutoresizingMaskIntoConstraints = false
		return ret
	}()
	

	override func setupLayout() {
		
		addSubview(collectionView)
		
		NSLayoutConstraint.activate([
		
			collectionView.topAnchor.constraint(equalTo: topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
		
		])
	}
	
	
	
}
