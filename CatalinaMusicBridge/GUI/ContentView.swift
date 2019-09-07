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

    private let foregroundColor = Color.white
    private let backgroundColor = Color.accentColor.opacity(0.9)
    
    var body: some View {
        ZStack {
            Image(nsImage: viewModel.artwork)
                .resizable()
                .scaledToFill()
            VStack(alignment: .center, spacing: 20.0) {
                Text(viewModel.title)
                    .font(.title)
                    .padding()
                    .foregroundColor(foregroundColor)
                    .background(backgroundColor)
                    .cornerRadius(5.0)
                Text(viewModel.currentTrack)
                    .padding()
                    .foregroundColor(foregroundColor)
                    .background(backgroundColor)
                    .cornerRadius(5.0)
                Text(viewModel.playerState)
                    .font(.footnote)
                    .padding()
                    .foregroundColor(foregroundColor)
                    .background(backgroundColor)
                    .cornerRadius(5.0)
            }
            .frame(minWidth: 512.0, minHeight: 512.0)
        }
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
