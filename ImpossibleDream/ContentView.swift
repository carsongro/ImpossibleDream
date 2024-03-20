//
//  ContentView.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/14/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var goals: [Goal]
    
    var body: some View {
        Group {
            if let goal = goals.first {
                GoalNavigationStack(goal: goal)
                    .transition(.move(edge: .bottom))
            } else {
                WelcomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
