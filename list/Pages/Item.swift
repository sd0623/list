//
//  Item.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import SwiftUI

struct Item: View {
    @StateObject var viewModel = ItemViewModel()
    
    let task: ItemModel
    var taskColor: Color
    
    var body: some View {
        HStack {
            Button {
                // update task
                viewModel.toggleIsDone(task: task)
            } label: {
                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.accentColor)
            }
                        
            VStack (alignment: .leading) {
                Text(task.title)
                    .font(.system(size: 25))
                    .foregroundColor(taskColor)
                
                
                Text("\(Date(timeIntervalSince1970: task.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            
        }
    }
}

#Preview {
    Item(task: .init(
        id: "123",
        title: "Study",
        dueDate: Date().timeIntervalSince1970,
        createdDate: Date().timeIntervalSince1970,
        isDone: false
    ), taskColor: .primary)
}
