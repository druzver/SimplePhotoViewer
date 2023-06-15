//
//  SearchPhotoListItemView.swift
//  SimplePhotoViewer
//
//  Created by Vitaly on 15.06.2023.
//

import SwiftUI


struct SearchPhotoListItemView: View {
	
	var model: PhotoModel
	var onDelete: (PhotoModel) -> Void

	@State private var isShowAskToRemove: Bool = false
	@State private var dragOffset = CGSize.zero
	
	var body: some View {
		
		Color.clear.overlay() {
			
			AsyncImage(url: URL(string: model.thumb)) { phase in
					   switch phase {
					   case .success(let image):
						   image
							   .resizable()
							   .scaledToFill()
					   default:
						   EmptyView()
					   }
				   }
			
		}
		.frame(maxWidth: .infinity)
		.aspectRatio(1, contentMode: .fit)
		.clipped()
		.offset(x: dragOffset.width)
		.rotationEffect(.degrees(Double(dragOffset.width / 20)), anchor: .center)

		.gesture(
			DragGesture()
				.onChanged({ gesture in
					dragOffset = gesture.translation
				})
				.onEnded({ gesture in
					if abs(dragOffset.width) > 50 {
						isShowAskToRemove = true
					}
					
					withAnimation() {
						dragOffset = .zero
					}
					
					
					
				})
		)
		.padding()
		.alert("Delete item ?", isPresented: $isShowAskToRemove) {
			Button("OK", role: .cancel) { onDelete(model) }
			Button("Cancel", role: .destructive) {
				
			}
			
		}
	}
}


#if DEBUG

struct SearchPhotoListItemView_Previews: PreviewProvider {
    static var previews: some View {
		SearchPhotoListItemView(model: PhotosStub.photos.first!, onDelete: { _ in })
    }
}

#endif
