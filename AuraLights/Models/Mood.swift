//
//  Mood.swift
//  AuraLights
//
//  Created by Aditi More on 7/2/25.
//


import SwiftUI

enum Mood: String, CaseIterable, Identifiable {
    case calm, happy, focused, romantic

    var id: String { self.rawValue }

    var color: Color {
        switch self {
        case .calm: return .blue
        case .happy: return .yellow
        case .focused: return .orange
        case .romantic: return .pink
        }
    }
}
