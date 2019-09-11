//
//  PlayerInfo.swift
//  CatalinaMusicBridge
//
//  Created by Boy van Amstel on 05/06/2019.
//  Copyright © 2019 Danger Cove. All rights reserved.
//

import AppKit

struct PlayerInfo {
    enum State: String {
        case unknown = "unknown"
        case playing = "kPSP"
        case paused = "kPSp"
        case stopped = "kPSS"
    }

    let state: State
    let artist: String
    let name: String
    let artwork: NSImage?

    init(state: State, artist: String? = nil, name: String? = nil, artwork: NSImage? = nil) {
        self.state = state
        self.artist = artist ?? "N/A"
        self.name = name ?? "N/A"
        self.artwork = artwork
    }
}
