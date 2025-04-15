//
//  freewriteApp.swift
//  infiwrite (Modified from freewrite)
//
//  Created by thorfinn on 2/14/25.
//  Modified by Eeman on 4/15/25.
//

import SwiftUI

@main
struct freewriteApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    // No longer need @AppStorage here as ContentView forces dark mode

    init() {
        // --- Font Registration (Optional) ---
        // If "Times New Roman" isn't sufficient and you add custom font files
        // (like PT Serif Caption) to the project, register them here:
        // registerFont(name: "PTSerifCaption-Regular", extension: "ttf")
        // registerFont(name: "PTSerifCaption-Italic", extension: "ttf")
        // etc.
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .toolbar(.hidden, for: .windowToolbar) // Keep toolbar hidden
        }
        .windowStyle(.hiddenTitleBar) // Keep title bar hidden
        .defaultSize(width: 800, height: 600) // Adjust default size if needed
        .windowResizability(.contentSize)
    }

    // Helper function to register fonts (if needed)
    /*
    private func registerFont(name: String, extension ext: String) {
        if let fontURL = Bundle.main.url(forResource: name, withExtension: ext) {
            CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, nil)
            print("Registered font: \(name).\(ext)")
        } else {
            print("Failed to find font: \(name).\(ext)")
        }
    }
    */
}

// AppDelegate remains useful for centering the window
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first {
            // Ensure window starts in windowed mode
            if window.styleMask.contains(.fullScreen) {
                window.toggleFullScreen(nil)
            }
            // Center the window on the screen
            window.center()
        }
    }
}
