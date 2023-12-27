//
//  Habit.swift
//  GoodHabits
//
//  Created by Son Cao on 27/12/2023.
//

import SwiftUI

@Observable
class Habits {
    var items = [HabitItem]()
}

struct HabitItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    var count: Int?
    
    var displayCount: String {
        if let count = count {
            return String(count)
        } else {
            return "0"
        }
    }
}



