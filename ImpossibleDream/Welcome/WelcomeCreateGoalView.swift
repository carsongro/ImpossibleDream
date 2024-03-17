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
    
    @State private var goalName = ""
    @State private var newTaskName = ""
    @State private var tasks = [GoalTask]()
    
    var body: some View {
        Form {
            Section {
                Text(goalName.isEmpty ? "Create Your Goal" : goalName)
                    .font(.largeTitle.bold())
                    .listRowBackground(Color.clear)
                    .safeAreaPadding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    .lineLimit(2)
                    .listRowSeparator(.hidden)
                
                Text("Impossible Dream is designed to help you \(goalName.isEmpty ? "achieve one goal" : goalName).")
                    .font(.title3)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            
            Section {
                TextField("Goal Name", text: $goalName)
                    .listRowBackground (Color.clear.background(.ultraThinMaterial))
            }
            
            Section {
                ForEach(tasks) { task in
                    Text(task.name)
                        .listRowBackground (Color.clear.background(.ultraThinMaterial))
                }
                .onDelete(perform: deleteTask)
                
                HStack {
                    TextField("Add a new task for \(goalName)", text: $newTaskName)
                    
                    Button("Add", action: addTask)
                }
                .listRowBackground (Color.clear.background(.ultraThinMaterial))
            } header: {
                Text("Tasks")
            } footer: {
                Text("The goal name and tasks can be changed later.")
            }
            
            Section {
                Button(action: createGoal) {
                    Text("Begin")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.plain)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30))
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
                .disabled(goalName.isEmpty)
            }
        }
        .scrollContentBackground(.hidden)
        .background(.clear)
    }
    
    func addTask() {
        guard newTaskName.isEmpty == false else { return }
        
        withAnimation {
            let task = GoalTask(name: newTaskName)
            tasks.append(task)
            newTaskName = ""
        }
    }
    
    func deleteTask(_ indexSet: IndexSet) {
        for index in indexSet {
            tasks.remove(at: index)
        }
    }
    
    func createGoal() {
        let goal = Goal(name: goalName, tasks: tasks)
        withAnimation {
            modelContext.insert(goal)
        }
    }
}

#Preview {
    WelcomeCreateGoalView()
}
