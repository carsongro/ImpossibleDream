//
//  TasksListView.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/15/24.
//

import SwiftUI
import SwiftData

struct TasksListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var tasks: [GoalTask]
    
    var goal: Goal
    
    var body: some View {
        List {
            Section {
                Text("Hello")
            }
            
            Section {
                ForEach(tasks) { task in
                    Text(task.name)
                }
            }
            
            Section {
                Button("Delete Goal") {
                    modelContext.delete(goal)
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
        return TasksListView(goal: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
