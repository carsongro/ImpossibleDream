//
//  GoalView.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/16/24.
//

import SwiftUI
import SwiftData

struct GoalView: View {
    var goal: Goal
    
    var body: some View {
        Text(goal.name)
            .toolbar {
                Menu("Options", systemImage: "ellipsis.circle") {
                    NavigationLink(value: goal) {
                        Label("Edit Goal", systemImage: "pencil")
                    }
                }
            }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Goal.self, configurations: config)
        let example = Goal(name: "Example Goal")
        return GoalView(goal: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
