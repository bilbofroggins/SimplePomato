//
//  UserDefaults.swift
//  Timer
//
//  Created by Patrick Cunniff on 6/4/23.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct SettingsData {
    @UserDefault(key: "launch_at_login", defaultValue: false)
    var launch_at_login: Bool
    
    @UserDefault(key: "timer_presets", defaultValue: [5, 10, 25])
    var timer_presets: [Int]
    
    @UserDefault(key: "alarm_volume", defaultValue: 25)
    var alarm_volume: Int
}

class SettingsManager: ObservableObject {
    static let instance = SettingsManager()

    @Published var settingsData: SettingsData

    private init() {
        settingsData = SettingsData()
    }
}
