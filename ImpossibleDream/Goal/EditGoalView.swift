//
//  EditGoalView.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/15/24.
//

import SwiftUI
import SwiftData

struct EditGoalView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var goal: Goal
    @State private var newTaskName = ""
    @State private var showingDeleteAlert = false
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Goal Name", text: $goal.name)
                    .listRowBackground(Color.clear.background(.ultraThinMaterial))
            }
            
            Section("Tasks") {
                ForEach(goal.tasks) { task in
                    Text(task.name)
                        .listRowBackground(Color.clear.background(.ultraThinMaterial))
                }
                .onDelete(perform: deleteTask)
                
                HStack {
                    TextField("Add a new task for \(goal.name)", text: $newTaskName)
                    
                    Button("Add", action: addTask)
                }
                .listRowBackground(Color.clear.background(.ultraThinMaterial))
            }
            
            Section {
                Button("Delete Goal", systemImage: "trash", role: .destructive) {
                    showingDeleteAlert.toggle()
                }
                .foregroundStyle(.red)
                .listRowBackground(Color.clear.background(.ultraThinMaterial))
                .confirmationDialog(
                    "Are you sure you want to delete this goal?",
                    isPresented: $showingDeleteAlert,
                    titleVisibility: .visible) {
                        Button("Cancel", role: .cancel) { showingDeleteAlert.toggle() }
                        Button("Delete", role: .destructive) { modelContext.delete(goal) }
                    }
            }
        }
        .navigationTitle("Edit Goal")
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .notvisionOS { $0.gradientBackground() }
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
        return EditGoalView(goal: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
