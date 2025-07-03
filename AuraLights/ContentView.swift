import SwiftUI

struct ContentView: View {
    @State private var selectedMood: Mood = .calm
    @State private var brightness: Double = 0.8
    @State private var lightColor: Color = Mood.calm.color

    var body: some View {
        VStack(spacing: 20) {
            LightPreviewView(color: lightColor, brightness: brightness)

            MoodSelectorView(selectedMood: $selectedMood, lightColor: $lightColor)

            BrightnessSliderView(brightness: $brightness)

            ColorPicker("Or pick your own color", selection: $lightColor)
                .padding()
        }
        .padding()
    }
}
