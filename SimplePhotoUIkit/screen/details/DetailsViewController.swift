//
//  DetailsViewController.swift
//  SimplePhotoUIkit
//
//  Created by Vitaly on 15.06.2023.
//

import UIKit





protocol DetailsPresenterProtocol: AnyObject {
	
	var view: DetailsViewProtocol? {get set}
	var router: DetailsRouter? {get set}
	
	func onTapClose()
	func onAppear()
	
}


protocol DetailsRouter: AnyObject {
	func close()
}


class DetailsPresenter : DetailsPresenterProtocol {
	
	
	private var model: PhotoModel
	
	weak var view: DetailsViewProtocol?
	var router: DetailsRouter?
	
	init(model: PhotoModel) {
		self.model = model
	}
	
	
	func onAppear() {
		view?.setImageUrl(url: model.largeImage)
	}
	
	func onTapClose() {
		router?.close()
	}
	
}



protocol DetailsViewProtocol : AnyObject {
	
	func setImageUrl(url: String)
}

class DetailsViewController : UIViewController , DetailsViewProtocol{
	
	
	
	private lazy var controllerView: DetailsView = { DetailsView() }()
	
	var presenter: DetailsPresenterProtocol?
	
	override func loadView() {
		view = controllerView
	}
	
	
	func setImageUrl(url: String) {
		controllerView.setImage(url: url)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapHandler))
		view.addGestureRecognizer(tapGesture)
		view.isUserInteractionEnabled = true
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter?.onAppear()
	}
	
	@objc
	private func onTapHandler() {
		presenter?.onTapClose()
	}
	
}


class DetailsView : BaseView {
	
	lazy var imageView: UIImageView = {
		let ret = UIImageView()
		ret.contentMode = .scaleAspectFit
		ret.clipsToBounds = true
		ret.translatesAutoresizingMaskIntoConstraints = false
		return ret
	}()
	
	override func setupLayout() {
		backgroundColor = .black
		addSubview(imageView)
		
		NSLayoutConstraint.activate([
		
			imageView.topAnchor.constraint(equalTo: topAnchor),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
		
		])
	}
	
	
	@MainActor
	func setImage(_ image: UIImage) {
		
		self.imageView.image = image
		layoutIfNeeded()
	}

	
	func setImage(url: String) {
		
		Task.detached {
			
			do {
				if let image = try await ImageLoader.downloadImage(url: url) {
					await self.setImage(image)
				}
			} catch {
				print(error.localizedDescription)
			}
			
		}
	}
}
