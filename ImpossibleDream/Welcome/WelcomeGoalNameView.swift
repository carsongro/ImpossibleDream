//
//  WelcomeGoalNameView.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/15/24.
//

import SwiftUI
import SwiftData

struct WelcomeGoalNameView: View {
    @Environment(\.modelContext) var modelContext
    
    @Bindable var goal: Goal
    @State private var newTaskName = ""
    
    var body: some View {
        Form {
            Text("Enter a name for a goal you will achieve")
                .listRowBackground(Color.clear)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .safeAreaPadding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            
            Section {
                TextField("Goal Name", text: $goal.name)
                    .listRowBackground (Color.clear.background(.ultraThinMaterial))
            }
            
            Section("Tasks") {
                ForEach(goal.tasks) { task in
                    Text(task.name)
                        .listRowBackground (Color.clear.background(.ultraThinMaterial))
                }
                .onDelete(perform: deleteTask)
                
                HStack {
                    TextField("Add a new task for \(goal.name)", text: $newTaskName)
                    
                    Button("Add", action: addTask)
                }
                .listRowBackground (Color.clear.background(.ultraThinMaterial))
            }
            
            Button("Delete") {
                withAnimation {
                    modelContext.delete(goal)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(.clear)
    }
    
    func addTask() {
        guard newTaskName.isEmpty == false else { return }
        
        withAnimation {
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
        return WelcomeGoalNameView(goal: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
