//
//  PhotosGridView.swift
//  SimplePhotoViewer
//
//  Created by Vitaly on 15.06.2023.
//

import SwiftUI


struct PhotosGridView: View {
	
	var items: [PhotoModel]
	var loading: Bool
	
	var needLoadNextPage: Bool
	
	var onNextPage: () -> Void
	
	
	let columns = [
		GridItem(.flexible(minimum: 80, maximum: .infinity)),
		GridItem(.flexible(minimum: 80, maximum: .infinity)),
		GridItem(.flexible(minimum: 80, maximum: .infinity)),
	]
	
	var body: some View {
		
		GeometryReader { proxy in
			ScrollView {
				
				LazyVGrid(columns: columns) {
					
					Section(content: {
						
						ForEach(items) { item in
							
							NavigationLink(destination: {
								DetailsPhotoScreenView(photo: item)
							}) {
								ItemView(item: item)
							}
							.buttonStyle(.plain)
							
						}
						
					}, footer: {
						
						if !loading {
							Text("").onAppear() {
								onNextPage()
							}
						}
						
						if !loading && needLoadNextPage {
							ProgressView("Loading")
						}
						
					})
					
				}.padding()
				
				
			}
			
		}
		
	}
	
	@ViewBuilder
	func ItemView(item: PhotoModel) -> some View {
		
		Color.clear.overlay() {
			
			AsyncImage(url: URL(string: item.thumb)) { phase in
				switch phase {
				case .success(let image):
					image
						.resizable()
				default:
					EmptyView()
				}
			}
			
		}
		.frame(maxWidth: .infinity)
		.aspectRatio(1, contentMode: .fit)
		.clipped()
	}
	
	
}

#if DEBUG

struct PhotosGridView_Previews: PreviewProvider {
	
	static var previews: some View {
		PhotosGridView(items: PhotosStub.photos, loading: false, needLoadNextPage: false, onNextPage: {})
	}
}

#endif
