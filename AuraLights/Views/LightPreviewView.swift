//
//  LightPreviewView.swift
//  AuraLights
//
//  Created by Aditi More on 7/2/25.
//


import SwiftUI

struct LightPreviewView: View {
    var color: Color
    var brightness: Double

    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(color.opacity(brightness))
            .frame(height: 250)
            .overlay(Text("Room Lighting").foregroundColor(.white))
            .padding()
            .animation(.easeInOut, value: color)
    }
}
