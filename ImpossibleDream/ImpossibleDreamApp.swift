//
//  ImpossibleDreamApp.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/14/24.
//

import SwiftUI
import SwiftData

@main
struct ImpossibleDreamApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: CoreHapticsManager.shared.prepareHaptics)
        }
        .modelContainer(for: Goal.self)
    }
}
