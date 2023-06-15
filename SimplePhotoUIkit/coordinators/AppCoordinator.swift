//
//  AppCoordinator.swift
//  SimplePhotoUIkit
//
//  Created by Vitaly on 15.06.2023.
//

import UIKit

@MainActor
class AppCoordinator {
	
	private let navigationController: UINavigationController
	
	private let DI: DIContainer
	
	init(navigationController: UINavigationController, DI: DIContainer ) {
		self.navigationController = navigationController
		self.DI = DI
	}
	
	
	func start() {
	
		let searchVC = SearchListViewController()
		searchVC.presenter = SearchListPresenter(repository: DI.photoRepository)
		searchVC.presenter?.view = searchVC
		searchVC.presenter?.router = self
		
		
		let vc = MainViewController()
		vc.presenter = MainPresenter(repository: DI.photoRepository)
		vc.presenter?.view = vc
		vc.presenter?.router = self
		
		vc.searchListViewController = searchVC
		vc.searchListPresenter = searchVC.presenter
		
		
		navigationController.viewControllers = [vc]
		
	}
}






extension AppCoordinator : MainRouterProtocol, SearchListRouterProtocol {

	func showPhoto(model: PhotoModel) {
		let coordinator = DetailsCoordinator(navigationController: navigationController, DI: DI)
		coordinator.start(model: model)
	}
	
	
}



