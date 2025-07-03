//
//  ScheduledMood.swift
//  AuraLights
//
//  Created by Aditi More on 7/2/25.
//


import SwiftUI

enum RepeatType: String, CaseIterable, Codable, Identifiable {
    case once, daily, weekends

    var id: String { self.rawValue }
}

struct ScheduledMood: Identifiable, Codable, Equatable {
    var id = UUID()
    var mood: Mood
    var time: Date
    var repeatType: RepeatType
}
