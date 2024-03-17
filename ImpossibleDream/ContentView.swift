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
        GoalNavigationStack()
            .fullScreenCover(isPresented: .constant(goals.count == 0), content: WelcomeView.init)
    }
}

#Preview {
    ContentView()
}
