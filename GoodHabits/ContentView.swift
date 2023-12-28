//
//  ContentView.swift
//  GoodHabits
//
//  Created by Son Cao on 27/12/2023.
//

import SwiftUI

struct ContentView: View {
    var habits = Habits()
    @State private var showAddHabitView = false
    
    var body: some View {
        NavigationStack {
            HabitListView(habits: habits)
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

struct HabitListView: View {
    let habits: Habits
    
    var body: some View {
        List {
            ForEach (habits.items) { habit in
                NavigationLink {
                    HabitDetailView(habit: habit, habits: habits)
                } label: {
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
            .onDelete(perform: { indexSet in
                habits.items.remove(atOffsets: indexSet)
            })
        }
    }
}




#Preview {
    let habits = Habits()
    if habits.items.count >= 3 {
        return ContentView(habits: habits)
    } else {
        habits.items.removeAll()
        let newHabit = HabitItem(name: "Plants", description: "Volumptious", icon: "🤗")
        habits.items.append(newHabit)
        return ContentView(habits: habits)
    }
}

