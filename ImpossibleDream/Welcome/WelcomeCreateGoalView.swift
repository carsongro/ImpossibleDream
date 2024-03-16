//
//  WelcomeCreateGoalView.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/15/24.
//

import SwiftUI
import SwiftData

struct WelcomeCreateGoalView: View {
    @Environment(\.modelContext) var modelContext
    
    @Bindable var goal: Goal
    @State private var newTaskName = ""
    
    let action: () -> Void
    
    var body: some View {
        Form {
            Section {
                Text(goal.name.isEmpty ? "Create Your Goal" : goal.name)
                    .font(.largeTitle.bold())
                    .listRowBackground(Color.clear)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .safeAreaPadding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    .lineLimit(2)
            }
            
            Section {
                TextField("Goal Name", text: $goal.name)
                    .listRowBackground (Color.clear.background(.ultraThinMaterial))
            }
            
            Section {
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
            } header: {
                Text("Tasks")
            } footer: {
                Text("The goal name and tasks can be changed later.")
            }
            
            Section {
                Button(action: action) {
                    Text("Done")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.plain)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30))
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
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
        return WelcomeCreateGoalView(goal: example) { }
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
