//
//  ContentView.swift
//  Timer
//
//  Created by Patrick Cunniff on 6/3/23.
//

import SwiftUI

struct CustomButton: View {
    let text: String
    @State var isActive: Bool = false
    
    var body: some View {
        Text(text)
            .onHover { isHovered in
                self.isActive = isHovered
            }
            .padding(.vertical, 3)
            .padding(.horizontal, 6)
            .background(isActive ? Color.white.opacity(0.15) : Color.clear)
            .cornerRadius(4)
    }
}

struct MainView: View {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @Binding var timeRemaining: Int
    @State private var selectedIndex = 2
    @State private var isPaused = true
    @State private var maxTime = 300
    @State private var currentTimerPreset = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var soundPlayer = SoundPlayer()
    
    @StateObject var settingsManager: SettingsManager = SettingsManager.instance

    var body: some View {
        VStack {
            HStack(spacing: 1) {
                ForEach(0..<100) { index in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(index == 100-Int((100*timeRemaining/maxTime)) ? Color.red : Color.gray.opacity(0.3))
                        .frame(width: index == selectedIndex ? 2 : 1.5, height: 20)
                }
            }
            
            HStack(spacing: 1) {
                Group {
                    if isPaused {
                        CustomButton(text: String(settingsManager.settingsData.timer_presets[0]) + "m")
                            .onTapGesture {
                                currentTimerPreset = 0
                                maxTime = max(settingsManager.settingsData.timer_presets[currentTimerPreset] * 60, 1)
                                timeRemaining = maxTime
                                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                                isPaused = false
                                soundPlayer.stopSound()
                            }
                        CustomButton(text: String(settingsManager.settingsData.timer_presets[1]) + "m")
                            .onTapGesture {
                                currentTimerPreset = 1
                                maxTime = max(settingsManager.settingsData.timer_presets[currentTimerPreset] * 60, 1)
                                timeRemaining = maxTime
                                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                                isPaused = false
                                soundPlayer.stopSound()
                            }
                        CustomButton(text: String(settingsManager.settingsData.timer_presets[2]) + "m")
                            .onTapGesture {
                                currentTimerPreset = 2
                                maxTime = max(settingsManager.settingsData.timer_presets[currentTimerPreset] * 60, 1)
                                timeRemaining = maxTime
                                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                                isPaused = false
                                soundPlayer.stopSound()
                            }
                    } else {
                        CustomButton(text: "cancel").onTapGesture {
                            timeRemaining = maxTime
                            isPaused = true
                        }
                        CustomButton(text: "restart").onTapGesture {
                            timeRemaining = maxTime
                            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                        }
                    }
                }
                Spacer()
                
                Menu {
                    Button("Settings") {
                        appDelegate.openCocoaWindow(id: "settings")
                    }
                    
                    Divider()
                    
                    Button("About SimplePomato") {
                        appDelegate.openCocoaWindow(id: "about")
                    }
                    
                    Button("Quit") {
                        NSApplication.shared.terminate(nil)
                    }
                } label: {
                }
                .menuStyle(BorderlessButtonMenuStyle())
            }
            
            Spacer().frame(height: 30)
            
            HStack(alignment: .lastTextBaseline) {
                Group {
                    if isPaused {
                        if timeRemaining == 0 {
                            CustomButton(text: "stop")
                            .onTapGesture {
                                maxTime = max(settingsManager.settingsData.timer_presets[currentTimerPreset] * 60, 1)
                                timeRemaining = maxTime
                                soundPlayer.stopSound()
                            }
                        } else {
                            CustomButton(text: "start")
                            .onTapGesture {
                                isPaused = false
                                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                                soundPlayer.stopSound()
                            }
                        }
                    } else {
                        CustomButton(text: "pause")
                        .onTapGesture {
                            isPaused = true
                        }
                    }
                }
                
                Spacer()
                
                Text("\(formatDuration(seconds: timeRemaining))")
                    .font(.system(size: 36))
                    .fontWeight(.thin)
                    .onReceive(timer) { _ in
                        if !isPaused && timeRemaining > 0 {
                            timeRemaining -= 1
                        }
                        if timeRemaining == 0 {
                            soundPlayer.playSound(volume: settingsManager.settingsData.alarm_volume)
                            isPaused = true
                        }
                    }
            }
            .foregroundColor(.primary)
        }
        .frame(width: 250)
        .padding(.all, 10.0)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(timeRemaining: .constant(245))
            .environmentObject(SettingsManager.instance)
    }
}
