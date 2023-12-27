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
                        HabitDetailView(habit: habit)
                    } label: {
                        HabitItemView(habit: habit)
                    }
                }
            }
            .navigationTitle(appData.name)
            .toolbar {
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
    habits.items.append(HabitItem(name: "Biking", description: "This is fun"))
    
    return ContentView(habits: habits)
}
