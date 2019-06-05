//
//  AppDelegate.swift
//  CatalinaMusicBridge
//
//  Created by Boy van Amstel on 04/06/2019.
//  Copyright © 2019 Danger Cove. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window = NSWindow.main
    private let listener = Listener()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        listener.start()

        let contentViewModel = ContentViewModel(listener: listener)
        let contentView = ContentView().environmentObject(contentViewModel)
        window.contentView = NSHostingView(rootView: contentView)

        window.center()
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        listener.stop()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

}

