import SwiftUI

struct SchedulerView: View {
    @Binding var selectedMood: Mood
    @Binding var lightColor: Color
    @Environment(\.dismiss) private var dismiss

    @State private var selectedDate = Date()
    @State private var selectedScheduledMood = Mood.calm
    @State private var selectedRepeat = RepeatType.once
    @State private var scheduledTasks: [ScheduledMood] = []

    @State private var showMoodChangeAlert = false
    @State private var justAppliedMood: Mood?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Schedule a Mood Change")
                    .font(.title2).bold()

                // Full Date & Time Picker
                DatePicker("Select Date & Time", selection: $selectedDate)
                    .datePickerStyle(.compact)
                    .padding(.horizontal)

                // Mood Picker
                Picker("Select Mood", selection: $selectedScheduledMood) {
                    ForEach(Mood.allCases) { mood in
                        Text(mood.rawValue.capitalized).tag(mood)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                // Repeat Type Picker
                Picker("Repeat", selection: $selectedRepeat) {
                    ForEach(RepeatType.allCases) { option in
                        Text(option.rawValue.capitalized).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                // Schedule Button
                Button("✅ Confirm Schedule") {
                    let newSchedule = ScheduledMood(mood: selectedScheduledMood,
                                                    time: selectedDate,
                                                    repeatType: selectedRepeat)
                    scheduledTasks.append(newSchedule)
                    scheduleMood(newSchedule)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)

                // Scheduled List
                if !scheduledTasks.isEmpty {
                    List {
                        ForEach(scheduledTasks) { task in
                            VStack(alignment: .leading) {
                                Text("\(task.mood.rawValue.capitalized) – \(task.repeatType.rawValue.capitalized)")
                                    .bold()
                                Text(formattedDate(task.time))
                                    .foregroundColor(.gray)
                            }
                        }
                        .onDelete(perform: deleteTask)
                    }
                    .frame(height: 200)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Mood Scheduler")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .alert(isPresented: $showMoodChangeAlert) {
                Alert(
                    title: Text("🎉 Mood Changed"),
                    message: Text("Mood is now set to \(justAppliedMood?.rawValue.capitalized ?? "")"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    // MARK: - Scheduler Logic
    func scheduleMood(_ task: ScheduledMood) {
        let delay = task.time.timeIntervalSinceNow
        guard delay > 0 else {
            print("⛔️ Time is in the past.")
            return
        }

        print("✅ Scheduled \(task.mood.rawValue) at \(formattedDate(task.time)) [\(task.repeatType.rawValue)]")

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let calendar = Calendar.current
            let weekday = calendar.component(.weekday, from: Date()) // Sunday = 1, Saturday = 7

            if task.repeatType == .weekends && !(weekday == 1 || weekday == 7) {
                return // Skip if not Sat/Sun
            }

            withAnimation {
                selectedMood = task.mood
                lightColor = task.mood.color
            }

            justAppliedMood = task.mood
            showMoodChangeAlert = true

            // Re-schedule if repeat type is daily/weekends
            if task.repeatType != .once {
                let nextDate = calendar.date(byAdding: .day, value: 1, to: task.time)!
                let repeatedTask = ScheduledMood(mood: task.mood, time: nextDate, repeatType: task.repeatType)
                scheduledTasks.append(repeatedTask)
                scheduleMood(repeatedTask)
            }

            // Remove current task
            if let index = scheduledTasks.firstIndex(of: task) {
                scheduledTasks.remove(at: index)
            }
        }
    }

    func deleteTask(at offsets: IndexSet) {
        scheduledTasks.remove(atOffsets: offsets)
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
