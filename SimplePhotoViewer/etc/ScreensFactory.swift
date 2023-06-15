//
//  ScreensFactory.swift
//  SimplePhotoViewer
//
//  Created by Vitaly on 15.06.2023.
//

import SwiftUI

protocol ScreensFactoryProtocol {
	
	func mainScreen() -> AnyView
	
	func detailsScreen(model: PhotoModel) -> AnyView
}


class ScreensFactory : ScreensFactoryProtocol , ObservableObject {
	
	private var proxy: ScreensFactoryProtocol? = nil
	
	init(_ proxy: ScreensFactoryProtocol? = nil) {
		self.proxy = proxy
	}
	
	
	func mainScreen() -> AnyView {
		return proxy?.mainScreen() ?? AnyView(EmptyView())
	}
	
	
	func detailsScreen(model: PhotoModel) -> AnyView {
		return proxy?.detailsScreen(model: model) ?? AnyView(EmptyView())
	}

}


class ScreensFactoryImpl : ScreensFactoryProtocol {
	
	private let di: DIContainer
	
	init(di: DIContainer = DIContainerImpl() ) {
		self.di = di
	}
		
	@MainActor
	 func mainScreen() -> AnyView {
		
		
		return AnyView( MainScreenView(
			viewModel: MainScreenViewModel(repository: di.photoRepository),
			searchViewModel: SearchPhotoViewModel(repository: di.photoRepository)
		))

	}
	
	@MainActor
	func detailsScreen(model: PhotoModel) -> AnyView {
		return AnyView(
			detailsScreen(model: model)
		)
	}
	
}
