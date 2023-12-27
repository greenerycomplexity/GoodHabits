//
//  AddHabitView.swift
//  GoodHabits
//
//  Created by Son Cao on 27/12/2023.
//

import SwiftUI

struct AddHabitView: View {
    @State private var name: String = ""
    @State private var description: String = ""
    @Environment(\.dismiss) var dismiss
    var habits: Habits
    
    var body: some View {
        NavigationStack {
            Form {
                TextField ("Name", text: $name)
                TextField ("Description", text: $description)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newHabit = HabitItem(name: name, description: description)
                        habits.items.append(newHabit)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            
        }
    }
}

#Preview {
    let habits = Habits()
    
    return AddHabitView(habits: habits)
}
