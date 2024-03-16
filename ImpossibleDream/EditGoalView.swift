//
//  EditGoalView.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/15/24.
//

import SwiftUI
import SwiftData

struct EditGoalView: View {
    @Bindable var goal: Goal
    @State private var newTaskName = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $goal.name)
            
            Section("Tasks") {
                ForEach(goal.tasks) { task in
                    Text(task.name)
                }
                .onDelete(perform: deleteTask)
                
                HStack {
                    TextField("Add a new task for \(goal.name)", text: $newTaskName)
                    
                    Button("Add", action: addTask)
                }
            }
        }
    }
    
    func addTask() {
        guard newTaskName.isEmpty == false else { return }
        
        withAnimation(.bouncy) {
            let task = GoalTask(name: newTaskName)
            goal.tasks.append(task)
            newTaskName = ""
        }
    }
    
    func deleteTask(_ indexSet: IndexSet) {
        for index in indexSet {
            goal.tasks.remove(at: index)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Goal.self, configurations: config)
        let example = Goal(name: "Example Goal")
        return EditGoalView(goal: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
