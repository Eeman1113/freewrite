// Swift 5.0
//
//  ContentView.swift
//  infiwrite (Modified from freewrite)
//
//  Created by thorfinn on 2/14/25.
//  Modified by Eeman on 4/15/25.
//

import SwiftUI
import AppKit // Needed for NSSavePanel, NSColor etc.
import UniformTypeIdentifiers // Needed for UTType

struct ContentView: View {

    // Use @AppStorage for automatic saving/loading (like localStorage)
    @AppStorage("infiwriteContent") private var text: String = "\n\n" // Default content

    // --- State for Hardcoded Appearance ---
    @State private var textFont: Font = .custom("Times New Roman", size: 18) // Use Times New Roman
    @State private var fontSize: CGFloat = 18 // Keep size consistent
    @State private var colorScheme: ColorScheme = .dark // Force dark scheme
    private let placeholderText: String = "\n\nClick here to start typing... (Cmd+S to Save)"

    // --- Body ---
    var body: some View {
        ZStack {
            // Force black background
            Color.black
                .ignoresSafeArea()

            // Main Text Editor
            TextEditor(text: $text)
                .font(textFont) // Apply the chosen font
                .foregroundColor(Color(nsColor: .lightGray)) // Light text on black
                .background(Color.black) // Ensure TextEditor background is black
                .scrollContentBackground(.hidden) // Hide default background
                .scrollIndicators(.never) // Hide scroll indicators (container handles scroll)
                .lineSpacing(fontSize * 0.5) // Adjust line spacing (approx 1.5x)
                .frame(maxWidth: 650) // Maintain max width for readability
                .padding(.horizontal, 30) // Add some horizontal padding
                .padding(.vertical, 20) // Add vertical padding
                .overlay(
                    // Placeholder Text Logic
                    ZStack(alignment: .topLeading) {
                        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Text(placeholderText)
                                .font(textFont)
                                .foregroundColor(.gray.opacity(0.6))
                                .allowsHitTesting(false)
                                .padding(.leading, 5) // Match TextEditor's internal padding
                                .padding(.top, 8)    // Match TextEditor's internal padding
                        }
                    }, alignment: .topLeading
                )
        }
        .preferredColorScheme(colorScheme) // Apply dark scheme preference
        .frame(minWidth: 700, minHeight: 500) // Set a minimum window size
        // Add Cmd+S Save Functionality via a hidden button
        .background(
            Button("Save") {
                saveAsTextFile()
            }
            .keyboardShortcut("s", modifiers: .command)
            .hidden() // Make the button invisible
        )
    }

    // --- Save Function ---
    private func saveAsTextFile() {
        print("Save Cmd+S triggered.")
        let textToSave = text // Use the current text state

        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [UTType.plainText] // Allow only .txt
        savePanel.canCreateDirectories = true
        savePanel.isExtensionHidden = false
        savePanel.title = "Save Freewrite Entry"
        savePanel.message = "Choose a location to save your text file."
        savePanel.nameFieldStringValue = "infiwrite_entry.txt" // Default filename

        // Show save dialog
        if savePanel.runModal() == .OK, let url = savePanel.url {
            do {
                try textToSave.write(to: url, atomically: true, encoding: .utf8)
                print("Successfully saved text file to: \(url.path)")
            } catch {
                print("Error saving text file: \(error)")
                // Optionally show an alert to the user
                let alert = NSAlert()
                alert.messageText = "Save Error"
                alert.informativeText = "Could not save the file: \(error.localizedDescription)"
                alert.alertStyle = .critical
                alert.addButton(withTitle: "OK")
                alert.runModal()
            }
        } else {
            print("Save cancelled by user.")
        }
    }
}

// --- Preview ---
#Preview {
    ContentView()
}
