//
//  SimplePhotoViewerApp.swift
//  SimplePhotoViewer
//
//  Created by Vitaly on 15.06.2023.
//

import SwiftUI

@main
struct SimplePhotoViewerApp: App {
	
	@State var DI: DIContainer = DIContainerImpl()
	
	var factory =  ScreensFactoryImpl()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(ScreensFactory(ScreensFactoryImpl(di: DI)))
				
        }
    }
	
}
