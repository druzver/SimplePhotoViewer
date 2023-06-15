//
//  BaseView.swift
//  SimplePhotoUIkit
//
//  Created by Vitaly on 15.06.2023.
//

import UIKit

class BaseView : UIView {
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupLayout()
		
	}
	
	
	
	func setupLayout() {}
	
	
	
}
