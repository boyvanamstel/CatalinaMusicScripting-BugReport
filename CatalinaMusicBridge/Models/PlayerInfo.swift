//
//  PlayerInfo.swift
//  CatalinaMusicBridge
//
//  Created by Boy van Amstel on 05/06/2019.
//  Copyright © 2019 Danger Cove. All rights reserved.
//

import Foundation
struct PlayerInfo {
    enum State: String {
        case unknown = "unknown"
        case playing = "kPSP"
        case paused = "kPSp"
        case stopped = "kPSS"
    }

    let state: State
    let artist: String
    let title: String

    init(state: State, artist: String? = nil, title: String? = nil) {
        self.state = state
        self.artist = artist ?? "N/A"
        self.title = title ?? "N/A"
    }
}
