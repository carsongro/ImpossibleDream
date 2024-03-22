//
//  GoalView.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/16/24.
//

import SwiftUI
import SwiftData

struct GoalView: View {
    @Bindable var goal: Goal
    
    var body: some View {
        Form {
            if goal.tasks.isEmpty {
                Section { } header: {
                    ContentUnavailableView {
                        Label("No Tasks", systemImage: "list.bullet.rectangle.portrait.fill")
                    } actions: {
                        NavigationLink(value: goal) {
                            Label("Add Tasks", systemImage: "plus.circle")
                        }
                    }
                    .textCase(.none)
                }
            } else {
                Section {
                    ForEach(goal.tasks) { task in
                        GoalTaskRowView(task: task)
                            .notvisionOS { $0.listRowBackground(Color.clear.background(.ultraThinMaterial)) }
                    }
                } header: {
                    Text("Tasks")
                }
            }
        }
        .scrollContentBackground(.hidden)
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
