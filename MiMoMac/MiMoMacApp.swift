//
//  MiMoMacApp.swift
//  MiMoMac
//
//  MiMo AI - macOS桌面版
//

import SwiftUI

@main
struct MiMoMacApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 1200, height: 800)
        .commands {
            CommandGroup(replacing: .newItem) {}
        }
    }
}
