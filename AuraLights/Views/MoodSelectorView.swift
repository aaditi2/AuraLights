//
//  MoodSelectorView.swift
//  AuraLights
//
//  Created by Aditi More on 7/2/25.
//


import SwiftUI

struct MoodSelectorView: View {
    @Binding var selectedMood: Mood
    @Binding var lightColor: Color

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Mood.allCases) { mood in
                    Button(action: {
                        selectedMood = mood
                        lightColor = mood.color
                    }) {
                        Text(mood.rawValue.capitalized)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .frame(minWidth: 80)
                            .lineLimit(1) // prevent wrapping
                            .background(selectedMood == mood ? mood.color.opacity(0.4) : Color.gray.opacity(0.2))
                            .cornerRadius(12)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
