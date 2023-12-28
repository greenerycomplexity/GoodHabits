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
    @State private var emoji = "🚀"
    @State private var showEmojiPicker = false
    @Environment(\.dismiss) var dismiss
    var habits: Habits
    
    var body: some View {
        NavigationStack {
            Form {
                TextField ("Name", text: $name)
                TextField ("Description", text: $description)
                HStack {
                    Text("Choose an icon")
                    Spacer()
                    Button {
                        showEmojiPicker = true
                    } label: {
                        Text(emoji)
                            .font(.system(size: 40))
                            .frame(minWidth: 80, minHeight: 80)
                            .background(.black.opacity(0.8))
                            .clipShape(Circle())
                            .overlay (
                                Circle()
                                    .strokeBorder(.blue, lineWidth: 5)
                            )
                    }
                }
            }
            .navigationTitle("Add new habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newHabit = HabitItem(name: name, description: description, icon: emoji)
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
            .sheet(isPresented: $showEmojiPicker) {
                EmojiPickerView(chosenEmoji: $emoji)
            }
            
        }
    }
}

#Preview {
    let habits = Habits()
    return AddHabitView(habits: habits)
}

#Preview {
    @State var emoji = "🚀"
    return EmojiPickerView(chosenEmoji: $emoji)
}
