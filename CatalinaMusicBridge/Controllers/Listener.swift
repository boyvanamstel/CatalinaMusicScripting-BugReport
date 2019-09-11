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

    private(set) var playerInfo = PlayerInfo(state: .unknown)
    
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
                         name: .musicPlayerInfo,
                         object: nil)

        updatePlayerInfo()
    }

    func stop() {
        guard isEnabled else { return }
        
        DistributedNotificationCenter.default().removeObserver(self)
    }
    
    // MARK: - Actions
    
    @objc private func handlePlayerStateChange(_ notification: Notification) {
        // Note: I'm aware we could use the player state from the `userInfo`, that's not the point of this example.

        updatePlayerInfo()
    }

    private func updatePlayerInfo() {
        let artist = fetchArtist()
        let name = fetchName()
        let state = fetchPlayerState()
        let artwork = fetchArtwork()
        let playerInfo = PlayerInfo(state: state, artist: artist, name: name, artwork: artwork)
        self.playerInfo = playerInfo

        didUpdatePlayerInfo?(playerInfo)
    }

    // MARK: - Scripts

    private func fetchArtist() -> String? {
        var error: NSDictionary?
        let source = """
        tell application "Music"
        get artist of current track
        end tell
        """
        let script = NSAppleScript(source: source)
        guard let output = script?.executeAndReturnError(&error) else {
            print("Track name error:\n\(error ?? [:])")
            return nil
        }

        return output.stringValue
    }

    private func fetchName() -> String? {
        var error: NSDictionary?
        let source = """
        tell application "Music"
        get name of current track
        end tell
        """
        let script = NSAppleScript(source: source)
        guard let output = script?.executeAndReturnError(&error) else {
            print("Track name error:\n\(error ?? [:])")
            return nil
        }

        return output.stringValue
    }

    private func fetchPlayerState() -> PlayerInfo.State {
        var error: NSDictionary?
        let source = """
tell application "Music"
player state
end
"""

        let script = NSAppleScript(source: source)
        guard let output = script?.executeAndReturnError(&error),
            let stateString = output.stringValue else {
            print("Player State error:\n\(error ?? [:])")
            return .unknown
        }

        let state = PlayerInfo.State(rawValue: stateString) ?? .unknown

        return state
    }

    private func fetchArtwork() -> NSImage? {
        var error: NSDictionary?
        let source = """
tell application "Music"
set trackArtworks to artworks of current track
if exists (every artwork) of current track
data of artwork 1 of current track
end if
end tell
"""

        let script = NSAppleScript(source: source)
        guard let output = script?.executeAndReturnError(&error) else {
            print("Artwork error:\n\(error ?? [:])")
            return nil
        }

        return NSImage(data: output.data)
    }

}
