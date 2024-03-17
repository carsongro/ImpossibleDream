//
//  GoalTaskRowView.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/16/24.
//

import SwiftUI
import SwiftData

struct GoalTaskRowView: View {
    @Bindable var task: GoalTask
    
    private var isCompleted: Bool { task.lastcompletionDate != nil }
    
    var body: some View {
        Button {
            task.lastcompletionDate = isCompleted ? nil : Date.now
        } label: {
            HStack {
                checkIndicator
                
                Text(task.name)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        #if !os(visionOS)
        .notvisionOS { $0.sensoryFeedback(.impact, trigger: isCompleted) }
        #endif
    }
    
    private var checkIndicator: some View {
        Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            .foregroundStyle(.thinMaterial)
            .accessibilityLabel(Text(isCompleted ? "Completed" : "Not complete"))
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Goal.self, configurations: config)
        let example = Goal(name: "Example Goal", tasks: [GoalTask(name: "")])
        return GoalTaskRowView(task: example.tasks[0])
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
