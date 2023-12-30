//
//  HabitDetailView.swift
//  GoodHabits
//
//  Created by Son Cao on 27/12/2023.
//

import SwiftUI

struct RectangleDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.gray)
    }
}

struct HabitDetailView: View {
    @Binding var navPath: [HabitItem]
    let emptyCompletionsTitle = "None so far, get into the habit today!"
    
    var habit: HabitItem
    var habits: Habits
    
    var body: some View {
        VStack {
            VStack (alignment: .leading) {
                Spacer()
                Text(habit.name)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.primary)
                
                Text(habit.description)
                
                Button("Delete activity", role: .destructive) {
                    if let index = habits.items.firstIndex(of: habit) {
                        habits.items.remove(at: index)
                        navPath.removeAll()
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Text("Previous completions: \(habit.displayCount)")
                Spacer()
                RectangleDivider()
                
            }
            
            VStack {
                HStack {
                    Text("Increment count")
                        .font(.title3.bold())
                        .foregroundStyle(.primary)
                    
                    Spacer()
                    
                    //                    Create temp habit to save replace current habit in the habits array
                    //                    since HabitItem is just a struct and Swift won't know it changed.
                    Button {
                        var tempHabit = habit
                        //                        Add new completion into Date array
                        let currentDate = Date.now
                        withAnimation {
                            tempHabit.completions.insert(currentDate, at: 0)
                        }
                        
                        if let index = habits.items.firstIndex(of: habit) {
                            habits.items[index] = tempHabit
                        }
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30))
                    }
                }
                
                if habit.completions.count != 0 {
                    List {
                        ForEach(habit.completions, id:\.self) { completion in
                            VStack (alignment: .leading) {
                                Text(completion.formatted(date: .abbreviated, time: .omitted))
                                    .font(.headline)
                                
                                Text(completion.formatted(date: .omitted, time: .shortened))
                            }
                            .listRowSeparator(.hidden)
                            .padding()
                            .background(.thinMaterial)
                            .clipShape(.rect(cornerRadius: 15))
                            
                            
                        }
                    }
                    .listStyle(.plain)
                    .background(.blue)
                } else {
                    Text(emptyCompletionsTitle)
                }
                
                
                
                
                Spacer()
            }
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    let habit = HabitItem(name: "Biking", description: "This is so fun and productive haha", icon: "🚴‍♂️")
    let habits = Habits()
    @State var navPath = [HabitItem]()
    return HabitDetailView(navPath: $navPath, habit: habit, habits: habits)
}
