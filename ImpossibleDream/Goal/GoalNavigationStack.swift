//
//  GoalNavigationStack.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/16/24.
//

import SwiftUI
import SwiftData

struct GoalNavigationStack: View {
    @Query var goals: [Goal]
    
    var body: some View {
        NavigationStack {
            Group {
                if let goal = goals.first {
                    GoalView(goal: goal)
                }
            }
            .navigationTitle(goals.first?.name ?? "My Goal")
            .navigationDestination(for: Goal.self, destination: EditGoalView.init)
        }
    }
}

#Preview {
    GoalNavigationStack()
}
