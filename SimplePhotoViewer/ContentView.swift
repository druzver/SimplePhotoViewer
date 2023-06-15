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
		}.navigationViewStyle(.stack)
		
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
