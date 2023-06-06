//
//  TimeHelper.swift
//  Timer
//
//  Created by Patrick Cunniff on 6/4/23.
//

import Foundation

func formatDuration(seconds: Int) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.zeroFormattingBehavior = .pad
    formatter.unitsStyle = .positional
    
    guard let formattedString = formatter.string(from: TimeInterval(seconds)) else {
        return ""
    }
    
    return formattedString
}
