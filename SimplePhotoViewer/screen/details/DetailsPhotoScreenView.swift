//
//  DetailsPhotoScreen.swift
//  SimplePhotoViewer
//
//  Created by Vitaly on 15.06.2023.
//

import SwiftUI



struct DetailsPhotoScreenView: View {
	
	var photo: PhotoModel
	
	var body: some View {
		ZStack {
			
			Color.clear.overlay() {
				
				AsyncImage(url: URL(string: photo.largeImage)) { phase in
						   switch phase {
						   case .success(let image):
							   image
								   .resizable()
								   .scaledToFit()
							   
							   
						   case .failure(let error):
							   HStack {
								   Text("Ooops 👻")
									   .font(.title)
									   .foregroundColor(.primary)
								   
								   Text("\(error.localizedDescription)")
									   .font(.subheadline)
									   .foregroundColor(.secondary)
							   }
							   Label("Ooops 👻", systemImage: "exclamationmark.triangle")
								   .labelStyle(.titleAndIcon)
						   default:
							   ProgressView()
						   }
					   }
				
				
				
			}
			.frame(maxWidth: .infinity)
		}
		.navigationTitle("Photo")
		.navigationBarTitleDisplayMode(.inline)
	}
}


#if DEBUG
struct DetailsPhotoScreenView_Previews: PreviewProvider {
    static var previews: some View {
		DetailsPhotoScreenView(photo: PhotosStub.photos.first!)
    }
}
#endif
