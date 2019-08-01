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
    typealias PublisherType = PassthroughSubject<ContentViewModel, Never>

    var didChange = PublisherType()
    var willChange = PublisherType()
    
    // MARK: - Properties
    
    var currentTrack: String {
        return "\(playerInfo.artist) - \(playerInfo.title)"
    }
    var playerState: String {
        return "\(playerInfo.state)"
    }
    
    private var playerInfo: PlayerInfo {
        didSet {
            didChange.send(self)
        }
    }

    private let listener: Listener

    // MARK: - Object lifecycle

    init(listener: Listener) {
        self.listener = listener
        self.playerInfo = listener.playerInfo
        
        listener.didUpdatePlayerInfo = { self.playerInfo = $0 }
    }

}
