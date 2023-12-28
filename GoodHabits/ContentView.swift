//
//  ContentView.swift
//  GoodHabits
//
//  Created by Son Cao on 27/12/2023.
//

import SwiftUI

struct HabitItemView: View {
    let habit: HabitItem
    
    var body: some View {
        HStack {
            Text(habit.displayCount)
                .font(.headline)
                .foregroundStyle(.white)
                .frame(width: 50, height: 50)
                .background(.green)
                .clipShape(.rect(cornerRadius:10))
            
            Text(habit.name)
                .font(.headline)
                .padding(.leading)
        }
    }
}




struct ContentView: View {
    var habits = Habits()
    @State private var showAddHabitView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach (habits.items) { habit in
                    NavigationLink {
                        HabitDetailView(habit: habit, habits: habits)
                    } label: {
                        HabitItemView(habit: habit)
                    }
                }
                .onDelete(perform: { indexSet in
                    habits.items.remove(atOffsets: indexSet)
                })
            }
            .navigationTitle(appData.name)
            .toolbar {
                if habits.items.count > 0 {
                    EditButton()
                }
                
                Button("Add Habit", systemImage: "plus.circle") {
                    showAddHabitView = true
                }
            }
            .sheet(isPresented: $showAddHabitView) {
                AddHabitView(habits: habits)
            }
        }
        
    }
}

#Preview {
    let habits = Habits()
    if habits.items.count >= 3 {
        return ContentView(habits: habits)
    } else {
        habits.items.removeAll()
        let newHabit = HabitItem(name: "Plants", description: "Volumptious")
        habits.items.append(newHabit)
        return ContentView(habits: habits)
    }
}
    
