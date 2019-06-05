//
//  ContentView.swift
//  CatalinaMusicBridge
//
//  Created by Boy van Amstel on 04/06/2019.
//  Copyright © 2019 Danger Cove. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            Text("Play a track in Music.app")
                .font(.title)
            Text("\(viewModel.currentTrack)")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        let contentViewModel = ContentViewModel(listener: Listener())
        let contentView = ContentView().environmentObject(contentViewModel)
        
        return contentView
    }
}
#endif
