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
            if let goal = goals.first {
                GoalView(goal: goal)
                    .navigationTitle(goals.first?.name ?? "My Goal")
                    .navigationDestination(for: Goal.self, destination: EditGoalView.init)
                    .notvisionOS { $0.background(gradient) }
            }
        }
    }
    
    private var gradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: (130.0 / 255.0), green: (109.0 / 255.0), blue: (204.0 / 255.0)),
                Color(red: (130.0 / 255.0), green: (130.0 / 255.0), blue: (211.0 / 255.0)),
                Color(red: (131.0 / 255.0), green: (160.0 / 255.0), blue: (218.0 / 255.0))
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
        .flipsForRightToLeftLayoutDirection(false)
        .ignoresSafeArea()
    }
}

#Preview {
    GoalNavigationStack()
}
