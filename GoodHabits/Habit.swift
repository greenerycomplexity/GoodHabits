//
//  Habit.swift
//  GoodHabits
//
//  Created by Son Cao on 27/12/2023.
//

import SwiftUI

@Observable
class Habits {
    let saveKey = appData.habitSaveKey
    
    var items = [HabitItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: saveKey)
            }
        }
    }
    
    init() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([HabitItem].self, from: savedData) {
                items = decoded
                return
            }
        }
        
        items = []
    }
    
}

struct HabitItem: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    let name: String
    let description: String
    let icon: String
    var completions = [Date]()
    
    var displayCount: String {
        String(completions.count)
    }
    
    var count: Int {
        completions.count
    }
}

