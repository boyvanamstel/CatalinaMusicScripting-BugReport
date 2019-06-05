//
//  ContentViewModel.swift
//  CatalinaMusicBridge
//
//  Created by Boy van Amstel on 05/06/2019.
//  Copyright © 2019 Danger Cove. All rights reserved.
//

import SwiftUI
import Combine

class ContentViewModel: BindableObject {
    var didChange = PassthroughSubject<ContentViewModel, Never>()
    
    // MARK: - Properties
    
    var currentTrack: String {
        return "\(playerInfo.artist) - \(playerInfo.title)"
    }
    
    private var playerInfo = PlayerInfo(artist: "N/A", title: "N/A") {
        didSet {
            didChange.send(self)
        }
    }

    private let listener: Listener

    // MARK: - Object lifecycle

    init(listener: Listener) {
        self.listener = listener
        
        listener.didUpdatePlayerInfo = { self.playerInfo = $0 }
    }

}
