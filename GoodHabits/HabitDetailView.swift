//
//  HabitDetailView.swift
//  GoodHabits
//
//  Created by Son Cao on 27/12/2023.
//

import SwiftUI

struct HabitDetailView: View {
    let emptyCompletionsTitle = "None so far, get into the habit today!"
    @Binding var navPath: [HabitItem]
    @State var habit: HabitItem
    var habits: Habits
    
    
    @State private var showDeleteWarning = false
    let deleteWarningTitle = "Delete this Habit?"
    let deleteWarningMessage = "All of this habit's completions data will be deleted"
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
            VStack {
                //            Habit Circle
                ZStack {
                    Circle()
                        .containerRelativeFrame(.horizontal) { width, axis in
                            width * 0.7
                        }
                        .foregroundStyle(.white)
                        .overlay(
                            Circle()
                                .strokeBorder(.green, lineWidth: 6)
                        )
                    
                    VStack {
                        Text(habit.icon)
                            .font(.system(size: 50))
                            .shadow(radius: 3)
                        
                        Text(habit.name)
                            .font(.title.bold())
                            .foregroundStyle(.black)
                            .fontDesign(.rounded)
                        
                        Button {
                            //                            Find the index of the current habit in the Observable class' array
                            if let index = habits.items.firstIndex(of: habit) {
                                //                                Add new completion
                                withAnimation {
                                    habit.completions.insert(Date.now, at: 0)
                                    //                                Add the new struct to the array where the old HabitItem was, so Swift knows it changed (for main Home view)
                                    habits.items[index] = habit
                                }
                            }
                            
                            
                        } label: {
                            Text("Track habit")
                                .fontDesign(.rounded)
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .padding(.top)
                    }
                }
                .padding(.bottom)
                
                VStack (spacing: 20) {
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Description")
                                .font(.title2.bold())
                                .fontDesign(.rounded)
                            
                            Text(habit.description)
                                .font(.subheadline)
                            
                        }
                        Spacer()
                    }
                    
                    //                List of previous completions
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Previous completions")
                                .font(.title2.bold())
                                .fontDesign(.rounded)
                            
                            CompletionListView(habit: habit)
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal)
                Spacer()
                
            }
        }
        .preferredColorScheme(.dark)
        .navigationTitle("Habit")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button("Delete") {
                    showDeleteWarning = true
                }
                .foregroundStyle(.red)
            }
        }
        .alert(deleteWarningTitle, isPresented: $showDeleteWarning) {
            Button("Delete", role: .destructive) {
                if let index = habits.items.firstIndex(of: habit) {
                    habits.items.remove(at: index)
                    navPath.removeAll()
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text(deleteWarningMessage)
        }
    }
}

struct CompletionListView: View {
    var habit: HabitItem
    
    var body: some View {
        if habit.count == 0 {
            Text("Nothing to show yet, start this habit today!")
                .font(.subheadline)
//                .padding(.top, 3)
        }
        
        
        //                Scroll view of all habit completions
        ScrollView {
            ForEach(habit.completions, id:\.self) { completion in
                HStack {
                    VStack (alignment: .leading) {
                        Text(completion.formatted(date: .abbreviated, time: .omitted))
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        Text(completion.formatted(date: .omitted, time: .shortened))
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .lineLimit(1)
                    }
                    .padding()
                    Spacer()
                    
                }
                .frame(maxWidth:.infinity)
                .background(.white.opacity(0.1))
                .clipShape(.rect(cornerRadius: 15))
            }
        }
    }
}

#Preview {
    let habit = HabitItem(name: "Biking", description: "This is so fun and productive haha", icon: "🚴‍♂️")
    let habits = Habits()
    @State var navPath = [HabitItem]()
    return HabitDetailView(navPath: $navPath, habit: habit, habits: habits)
}
