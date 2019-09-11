//
//  ContentViewModel.swift
//  CatalinaMusicBridge
//
//  Created by Boy van Amstel on 05/06/2019.
//  Copyright © 2019 Danger Cove. All rights reserved.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {

    // MARK: - Properties

    let title = "Play a track in Music.app"

    @Published var currentTrack = ""
    @Published var playerState = ""
    @Published var artwork: NSImage?
    
    private var playerInfo: PlayerInfo {
        didSet {
            update(playerInfo)
        }
    }

    private let listener: Listener

    // MARK: - Object lifecycle

    init(listener: Listener) {
        self.listener = listener
        self.playerInfo = listener.playerInfo
        update(self.playerInfo)
        
        listener.didUpdatePlayerInfo = { self.playerInfo = $0 }
    }

    // MARK: - Player info

    private func update(_ playerInfo: PlayerInfo) {
        currentTrack = "\(playerInfo.artist) - \(playerInfo.name)"
        playerState = "State: \(playerInfo.state)"
        artwork = playerInfo.artwork
    }

}
