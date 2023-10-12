//
//  AddItem.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import SwiftUI

struct AddItem: View {
    @StateObject var viewModel = AddItemViewModel()
    @Binding var addItemPresented: Bool
    
    var body: some View {
        VStack {
            Text("Add Task")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 80)
            
            Spacer()
            Form {
                // Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .padding()
                
                // Due Date
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                // Button
                ListButton(
                    title: "Add",
                    bgColor: .blue)
                {
                    // add task
                    if viewModel.canAdd {
                        viewModel.add()
                        addItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                    
                }
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill all fields and select today or future due date!"))
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    AddItem(addItemPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }))
}
