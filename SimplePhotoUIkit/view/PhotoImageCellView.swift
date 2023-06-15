//
//  PhotoImageCellView.swift
//  SimplePhotoUIkit
//
//  Created by Vitaly on 15.06.2023.
//

import UIKit



class PhotoImageCellView : UICollectionViewCell {
	
	typealias OnTapDelete = () -> Void
	
	var onTapDelete: OnTapDelete?
		
	lazy var deleteButton: UIButton = {
		let ret = UIButton(type: .custom)
		let image = UIImage(systemName: "trash")

		ret.tintColor = .red
		ret.setImage(image, for: .normal)
		ret.translatesAutoresizingMaskIntoConstraints = false
		ret.addTarget(self, action: #selector(onTapDeleteHandler), for: .touchUpInside)
		ret.isHidden = true
		
		return ret
	}()
	
	
	lazy var imageView: UIImageView = {
		let ret = UIImageView()
		ret.contentMode = .scaleAspectFill
		ret.clipsToBounds = true
		ret.backgroundColor = .gray.withAlphaComponent(0.3)
		ret.translatesAutoresizingMaskIntoConstraints = false
		return ret
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	override func prepareForReuse() {
		imageView.image = nil
	}
	
	func setupLayout() {
		
		contentView.addSubview(imageView)
		contentView.addSubview(deleteButton)
		
		contentView.layoutMargins = .zero
		
		let guide = contentView.layoutMarginsGuide
		
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: guide.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
			
			deleteButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 5),
			deleteButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -5),
			deleteButton.widthAnchor.constraint(equalToConstant: 30),
			deleteButton.heightAnchor.constraint(equalToConstant: 30),
			
			contentView.heightAnchor.constraint(equalTo: contentView.widthAnchor)
			
		])
		
	}
	
	@objc private func onTapDeleteHandler() {
		onTapDelete?()
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



