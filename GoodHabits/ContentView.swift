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
            ZStack {
                Color.gray.opacity(0.2)
                    .ignoresSafeArea()
                
                //            Greeting + Tree image
                VStack {
                    HStack {
                        VStack (alignment: .leading) {
                            Text("G'day!")
                                .font(.largeTitle.bold())
                                .fontDesign(.rounded)
                            Text("What are your plans today?")
                        }
                        
                        .frame(width: 220, height: 150)
                        
                        Image("tree")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                    }
                    
                    
                    
                    HabitListView(habits: habits)
                        .toolbar {
                            if habits.items.count > 0 {
                                ToolbarItem (placement: .topBarLeading) {
                                    EditButton()
                                }
                            }
                            ToolbarItem (placement: .topBarTrailing) {
                                Button("Add Habit", systemImage: "plus.circle") {
                                    showAddHabitView = true
                                }
                            }
                        }
                    
                    
                    //                Add new habit button
                    Button {
                        showAddHabitView = true
                    } label: {
                        HStack {
                            Spacer()
                            ZStack {
                                Circle()
                                    .frame(width: 40)
                                    .foregroundStyle(.white)
                                
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundStyle(.green)
                            }
                        }
                    }
                    .padding()
                    .sheet(isPresented: $showAddHabitView) {
                        AddHabitView(habits: habits)
                    }
                    
                }
            }
            .preferredColorScheme(.dark)
            .navigationTitle(appData.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HabitListView: View {
    let habits: Habits
    
    var body: some View {
        //                Scroll view of all habits
        ScrollView {
            ForEach (habits.items) { habit in
                NavigationLink {
                    HabitDetailView(habit: habit, habits: habits)
                } label: {
                    HStack {
                        Text(habit.icon)
                            .font(.system(size: 35))
                            .frame(height: 80)
                            .padding(.leading)
                        
                        VStack (alignment: .leading) {
                            Text(habit.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            Text(habit.description)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .lineLimit(1)
                        }
                        .padding(.leading, 10)
                        
                        Spacer()
                        
                        
                        VStack {
                            Text(habit.displayCount)
                                .font(.title2.bold())
                                .fontWeight(.heavy)
                                .foregroundStyle(habit.count == 0 ? .red.opacity(0.8) : .white)
                            
                            Text ("times")
                                .font(.subheadline)
                        }
                        .foregroundStyle(.white)
                        .fontDesign(.rounded)
                        
                        //                        Arrow for nav link
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 7)
                            .foregroundColor(.white) //Apply color for arrow only
                            .padding(.horizontal)
                        
                    }
                    .frame(maxWidth:.infinity)
                    .background(.white.opacity(0.1))
                    .clipShape(.rect(cornerRadius: 15))
                }
                .padding(.horizontal)
            }
            .onDelete(
                perform: { indexSet in
                    habits.items.remove(atOffsets: indexSet)}
            )
        }
    }
}


#Preview {
    let habits = Habits()
    if habits.items.count >= 3 {
        return ContentView(habits: habits)
    } else {
        habits.items.removeAll()
        let newHabit = HabitItem(name: "Plants", description: "Very fun activity indeed", icon: "🌿")
        habits.items.append(newHabit)
        return ContentView(habits: habits)
    }
}

