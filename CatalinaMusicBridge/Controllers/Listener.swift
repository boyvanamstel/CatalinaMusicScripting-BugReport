//
//  Listener.swift
//  CatalinaMusicBridge
//
//  Created by Boy van Amstel on 05/06/2019.
//  Copyright © 2019 Danger Cove. All rights reserved.
//

import AppKit

class Listener {
    
    // MARK: - Properties
    
    var didUpdatePlayerInfo: ((PlayerInfo) -> Void)?
    
    // MARK: - Object lifecycle
    
    deinit {
        stop()
    }
    
    // MARK: - Observers
    
    private var isEnabled = false
    
    func start() {
        guard !isEnabled else { return }
        isEnabled = true
        
        DistributedNotificationCenter
            .default()
            .addObserver(self,
                         selector: #selector(handlePlayerStateChange(_:)),
                         name: .iTunesPlayerInfo,
                         object: nil)
    }
    
    func stop() {
        guard isEnabled else { return }
        
        DistributedNotificationCenter.default().removeObserver(self)
    }
    
    // MARK: - Actions
    
    @objc private func handlePlayerStateChange(_ notification: Notification) {
        // Note: I'm aware we could use the player state from the `userInfo`, that's not the point of this example.
//        let artist = notification.userInfo?["Artist"] as? String ?? ""
//        let title = notification.userInfo?["Name"] as? String ?? ""

        // Update player state through AppleScript
        let source = """
property trackName : \"\"
property trackArtist : \"\"
tell application \"Music\"
set trackName to name of current track
set trackArtist to artist of current track
end tell
return {trackArtist, trackName}
"""
        let script = NSAppleScript(source: source)
        var error: NSDictionary?
        guard let output = script?.executeAndReturnError(&error) else {
            print("AppleScript error:\n\(error ?? [:])")
            return
        }
        
        let artist = output.atIndex(1)?.stringValue ?? ""
        let title = output.atIndex(2)?.stringValue ?? ""

        let playerInfo = PlayerInfo(artist: artist, title: title)

        didUpdatePlayerInfo?(playerInfo)
    }
    
}
