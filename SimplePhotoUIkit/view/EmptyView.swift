//
//  EmptyView.swift
//  SimplePhotoUIkit
//
//  Created by Vitaly on 15.06.2023.
//

import UIKit

class EmptyView : BaseView {
	
	lazy var label: UILabel = {
		let ret = UILabel()
		ret.text = "Not Found 😱 "
		ret.font = .systemFont(ofSize: 18)
		ret.translatesAutoresizingMaskIntoConstraints = false
		return ret
	}()
	
	override func setupLayout() {
		backgroundColor = .white
		addSubview(label)
		
		NSLayoutConstraint.activate([
			label.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
			label.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
		
		])
	}
}
