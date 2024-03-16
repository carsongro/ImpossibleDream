//
//  GoalTask.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/15/24.
//

import Foundation
import SwiftData

@Model
class GoalTask {
    var name: String
    var lastcompletionDate: Date?
    
    init(
        name: String = "",
        lastcompletionDate: Date? = nil
    ) {
        self.name = name
        self.lastcompletionDate = lastcompletionDate
    }
}
