import SwiftUI

@main
struct UtilityApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State private var timeRemaining: Int = 300

    var body: some Scene {
        MenuBarExtra {
            MainView(timeRemaining: $timeRemaining)
        } label: {
            Text(String(formatDuration(seconds: timeRemaining)))
        }
        .menuBarExtraStyle(.window)
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}


import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var aboutWindow: NSWindow!
    var settingsWindow: NSWindow!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        createAboutWindow()
        createSettingsWindow()
    }
    
    func createAboutWindow() {
        aboutWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 270),
            styleMask: [.borderless, .closable],
            backing: .buffered,
            defer: false
        )
        
        aboutWindow.titleVisibility = .hidden
        aboutWindow.isMovableByWindowBackground = true
        
        let aboutView = AboutView(closeWindow: closeCocoaWindow)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        aboutWindow.contentView = NSHostingView(rootView: aboutView)
        aboutWindow.center()
        aboutWindow.isReleasedWhenClosed = false
    }
    
    func createSettingsWindow() {
        settingsWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 270, height: 290),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        
        settingsWindow.titleVisibility = .hidden
        settingsWindow.isMovableByWindowBackground = true

        let settingsView = SettingsView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        settingsWindow.contentView = NSHostingView(rootView: settingsView)
        settingsWindow.center()
        settingsWindow.isReleasedWhenClosed = false
    }

    func openCocoaWindow(id: String) {
        switch id {
        case "about":
            aboutWindow.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
        case "settings":
            createSettingsWindow()
            settingsWindow.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
        default:
            break
        }
    }
    
    func closeCocoaWindow(id: String) {
        switch id {
        case "about":
            aboutWindow.close()
        case "settings":
            settingsWindow.close()
        default:
            break
        }
    }
}
