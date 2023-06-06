import SwiftUI

@main
struct UtilityApp: App {
    @State private var timeRemaining: Int = 300
    @StateObject private var settingsManager = SettingsManager()

    var body: some Scene {
        MenuBarExtra {
            MainView(timeRemaining: $timeRemaining)
                .environmentObject(settingsManager)
        } label: {
            Text(String(formatDuration(seconds: timeRemaining)))
        }
        .menuBarExtraStyle(.window)
        Window("About", id: "about") {
            AboutView()
        }
        Window("Settings", id: "settings") {
            SettingsView().environmentObject(settingsManager)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

