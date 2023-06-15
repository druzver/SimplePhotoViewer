//
//  SearchPhotoListView.swift
//  SimplePhotoViewer
//
//  Created by Vitaly on 15.06.2023.
//

import SwiftUI


struct SearchPhotoListView: View {
	
	@ObservedObject
	var viewModel: SearchPhotoViewModel

	var body: some View {
		
		ScrollView {

			LazyVStack(spacing: 8) {
				
				ForEach(viewModel.items) { item in
										
					NavigationLink {
						DetailsPhotoScreenView(photo: item)
					} label: {
						SearchPhotoListItemView(model: item, onDelete: { _ in
							withAnimation() {
								viewModel.remove(item: item)
							}
						})
					}
					.buttonStyle(.plain)
					

					
					
				}.onDelete { index in
					viewModel.removeImage(at: index)
				}
				
				Color.white.onAppear() {
					viewModel.loadNextPage()
				}
				
				if viewModel.loading {
					ZStack {
						Color.white.ignoresSafeArea()
						ProgressView()
					}
				}
				
			}
			
		}.overlay() {
			if viewModel.isResultEmpty && viewModel.errorMessage == nil {
				Text("Not found")
			}
		}
		.overlay() {
			if let message = viewModel.errorMessage {
				Text(message)
			}
		}
		
		
	}
	
}


#if DEBUG
struct SearchPhotoListView_Previews: PreviewProvider {
    static var previews: some View {
		let model = SearchPhotoViewModel(repository: FakeRepository.shared)
		SearchPhotoListView(viewModel: model)
			.previewEnviroments()
			.onAppear() {
				model.setSearchText(query: "test")
			}
    }
}


#endif
