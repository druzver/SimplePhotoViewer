//
//  MainScreenView.swift
//  SimplePhotoViewer
//
//  Created by Vitaly on 15.06.2023.
//

import SwiftUI

struct MainScreenView: View {
	
	@ObservedObject
	var viewModel: MainScreenViewModel
	
	@ObservedObject
	var searchViewModel: SearchPhotoViewModel
	
	
	var body: some View {
		
		ZStack {
			
			if viewModel.searchText.isEmpty {
				PhotosGridView(
					items: viewModel.items,
					loading: viewModel.loading,
					needLoadNextPage: !viewModel.isLastPage,
					onNextPage: {
						viewModel.fetchNextPage()
					}
				)
			} else {
				SearchPhotoListView(viewModel: searchViewModel)
			}

		}.onAppear() {
			viewModel.loadFirstPage()
		}
		.navigationTitle("Photos")
		.navigationBarTitleDisplayMode(.inline)
		
		.searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
		.onSubmit(of: .search) {
			let query = viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines)
			searchViewModel.setSearchText(query: query)
		}
	}
}




#if DEBUG
struct MainScreenView_Previews: PreviewProvider {
	
    static var previews: some View {
		
        MainScreenView(
			viewModel: MainScreenViewModel(repository:  FakeRepository.shared ),
			searchViewModel: SearchPhotoViewModel( repository: FakeRepository.shared )
		)
			.previewEnviroments()
			
    }
}

#endif
