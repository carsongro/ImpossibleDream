//
//  GoalNavigationStack.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/16/24.
//

import SwiftUI
import SwiftData

struct GoalNavigationStack: View {
    @Bindable var goal: Goal
    
    var body: some View {
        NavigationStack {
            GoalView(goal: goal)
                .navigationTitle(goal.name)
                .navigationDestination(for: Goal.self, destination: EditGoalView.init)
                .notvisionOS { $0.gradientBackground() }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Goal.self, configurations: config)
        let example = Goal(name: "Example Goal")
        return GoalNavigationStack(goal: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
