//
//  DetailsCoordinator.swift
//  SimplePhotoUIkit
//
//  Created by Vitaly on 15.06.2023.
//

import UIKit


class DetailsCoordinator {
	
	private let navigationController: UINavigationController
	private let DI: DIContainer

	init( navigationController: UINavigationController, DI: DIContainer ) {
		self.navigationController = navigationController
		self.DI = DI
	}
	
	@MainActor
	func start(model: PhotoModel) {
		
		let vc = DetailsViewController()
		
		vc.presenter = DetailsPresenter(model: model)
		vc.presenter?.view = vc
		vc.presenter?.router = self
		
		vc.modalTransitionStyle = .crossDissolve
		vc.modalPresentationStyle = .fullScreen
		navigationController.present(vc, animated: true)
		
	}
}


extension DetailsCoordinator : DetailsRouter {
	
	func close() {
		navigationController.dismiss(animated: true)
	}
	
}
