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
        //            .padding(.vertical)
    }
}

struct HabitDetailView: View {
    var habit: HabitItem
    
    var body: some View {
        VStack {
            VStack (alignment: .leading) {
                Spacer()
                Text(habit.name)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.primary)
                
                Text(habit.description)
                
                Spacer()
                RectangleDivider()
                
                Text("Increment count")
                    .font(.title3.bold())
                    .foregroundStyle(.primary)
                
            }
  
            VStack {
                HStack {
                    Button {
                    } label: {
                        Image(systemName: "minus.circle")
                            .font(.system(size: 30))
                    }
                    
                    Text(habit.displayCount)
                        .frame(width: 70, height: 50)
                        .background(.thickMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.horizontal)
                    
                    Button {
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                    .font(.system(size: 30))
                }
                
                Spacer()
            }
            
        }
        .navigationTitle(habit.name)
        .padding(.horizontal)
    }
}

#Preview {
    let habit = HabitItem(name: "Biking", description: "This is so fun and productive haha")
    return HabitDetailView(habit: habit)
}
