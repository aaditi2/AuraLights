import SwiftUI

struct ContentView: View {
    @State private var selectedMood: Mood = .calm
    @State private var brightness: Double = 0.8
    @State private var lightColor: Color = Mood.calm.color
    @State private var showScheduler = false

    var body: some View {
        VStack(spacing: 20) {
            LightPreviewView(color: lightColor, brightness: brightness)

            MoodSelectorView(selectedMood: $selectedMood, lightColor: $lightColor)

            BrightnessSliderView(brightness: $brightness)

            ColorPicker("Pick a light color", selection: $lightColor)
                .padding()

            // Schedule Button
            Button(action: {
                showScheduler = true
            }) {
                Text("📆 Schedule Mood")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .sheet(isPresented: $showScheduler) {
            SchedulerView(selectedMood: $selectedMood, lightColor: $lightColor)
        }
        .padding()
    }
}
