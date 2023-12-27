//
//  HabitDetailView.swift
//  GoodHabits
//
//  Created by Son Cao on 27/12/2023.
//

import SwiftUI

struct HabitDetailView: View {
    let habit: HabitItem
    
    
    var body: some View {
        ScrollView {
            Text("Hello")
        }
        .navigationTitle(habit.name)
    }
}

#Preview {
    let habit = HabitItem(name: "Biking", description: "This is so fun and productive haha")
    return HabitDetailView(habit: habit)
}
