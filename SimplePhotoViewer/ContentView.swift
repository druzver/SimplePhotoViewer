//
//  ContentView.swift
//  SimplePhotoViewer
//
//  Created by Vitaly on 15.06.2023.
//

import SwiftUI
import SimplePhotoNetwork

struct ContentView: View {
	
	@EnvironmentObject var screenFactory : ScreensFactory
	
	
    var body: some View {
		
		NavigationView {
			screenFactory.mainScreen()
		}
		
		
//
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//        .padding()
//		.task() {
//			do {
//				let photos = try await UnSplashPhotoRepository.shared.getPhotos(PhotosRequest())
//				print(photos)
//			} catch {
//				print(error)
//			}
//
//		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
