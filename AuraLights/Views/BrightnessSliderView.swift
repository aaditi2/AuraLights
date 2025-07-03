//
//  BrightnessSliderView.swift
//  AuraLights
//
//  Created by Aditi More on 7/2/25.
//


import SwiftUI

struct BrightnessSliderView: View {
    @Binding var brightness: Double

    var body: some View {
        VStack {
            Text("Brightness: \(Int(brightness * 100))%")
            Slider(value: $brightness, in: 0...1)
        }
        .padding()
    }
}
