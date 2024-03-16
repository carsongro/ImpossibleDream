//
//  Goal.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/15/24.
//

import Foundation
import SwiftData

@Model
class Goal {
    var name: String
    var isComplete: Bool
    @Relationship(deleteRule: .cascade) var tasks = [GoalTask]()
    
    init(
        name: String = "",
        isComplete: Bool = false
    ) {
        self.name = name
        self.isComplete = isComplete
    }
}
