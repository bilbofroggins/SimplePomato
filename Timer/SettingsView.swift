//
//  SettingsView.swift
//  Timer
//
//  Created by Patrick Cunniff on 6/4/23.
//

import SwiftUI

import ServiceManagement

func setLaunchAtLogin(enabled: Bool) {
    if enabled {
        try? SMAppService().register()
    } else {
        try? SMAppService().unregister()
    }
}

struct SettingsView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    
    @State private var soundPlayer = SoundPlayer()
    
    var body: some View {
        Form {
            VStack {
                Text("timer presets (min):")
                HStack(alignment: .center) {
                    Spacer()
                    TextField("", text: Binding(
                        get: { String(settingsManager.settingsData.timer_presets[0]) },
                        set: { settingsManager.settingsData.timer_presets[0] = ((Int($0) == 0 ? 1 : Int($0)) ?? 1)}
                    ))
                        .frame(width: 40)
                        .multilineTextAlignment(.center)
                    TextField("", text: Binding(
                        get: { String(settingsManager.settingsData.timer_presets[1]) },
                        set: { settingsManager.settingsData.timer_presets[1] = ((Int($0) == 0 ? 1 : Int($0)) ?? 1) }
                    ))
                        .frame(width: 40)
                        .multilineTextAlignment(.center)
                    TextField("", text: Binding(
                        get: { String(settingsManager.settingsData.timer_presets[2]) },
                        set: { settingsManager.settingsData.timer_presets[2] = ((Int($0) == 0 ? 1 : Int($0)) ?? 1) }
                    ))
                        .frame(width: 40)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                Divider()
                Text("alarm volume:")
                HStack {
                    Image(systemName: "volume.1.fill")
                    Slider(value: Binding(
                        get: { Double(settingsManager.settingsData.alarm_volume) },
                        set: { settingsManager.settingsData.alarm_volume = Int($0) }
                    ), in: 0...100)
                    Image(systemName: "volume.3.fill")
                }.padding()
                HStack {
                    Text("Test")
                    Image(systemName: "volume.2")
                        .onTapGesture {
                            soundPlayer.playTestSound(volume: settingsManager.settingsData.alarm_volume)
                        }
                        .onHover { isHovered in
                            if isHovered {
                                NSCursor.pointingHand.push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                }.padding()
                Divider()
                Toggle("launch at login", isOn: $settingsManager.settingsData.launch_at_login)
                    .padding()
                    .onChange(of: settingsManager.settingsData.launch_at_login) { launchAtLogin in
                        if launchAtLogin {
                            setLaunchAtLogin(enabled: true)
                        } else {
                            setLaunchAtLogin(enabled: false)
                        }
                    }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @StateObject private var settingsManager = SettingsManager()
    static var previews: some View {
        SettingsView().environmentObject(SettingsManager())
    }
}
