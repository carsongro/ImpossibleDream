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
    @State private var path = [Goal]()
    @Query var goals: [Goal]
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if goals.isEmpty {
                    WelcomeView(action: addGoal)
                } 
                else if let goal = goals.first {
                    TasksListView(goal: goal)
                }
            }
            .navigationDestination(for: Goal.self, destination: EditGoalView.init)
        }
    }
    
    func addGoal() {
        let goal = Goal()
        modelContext.insert(goal)
        path = [Goal()]
    }
}

#Preview {
    ContentView()
}
