//
//  ItemList.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import FirebaseFirestoreSwift
import SwiftUI

struct ItemList: View {
    @StateObject var viewModel: ItemListViewModel
    // live listen
    @FirestoreQuery var tasks: [ItemModel]
        
    init(userId: String) {
        // users/<id>/tasks/<entries>
        self._tasks = FirestoreQuery(
            collectionPath: "users/\(userId)/tasks"
        )
        
        self._viewModel = StateObject(
            wrappedValue: ItemListViewModel(userId: userId)
        )
    }
    
    var body: some View {
        NavigationView{
            
            VStack {
//                Header(size: 30.0, height: 100)
//                    .offset(y: -90)
                
                List(tasks) { task in
                    Item(task: task)
                        .swipeActions{
                            Button{
                                // delete
                                viewModel.delete(id: task.id)
                            } label: {
                                Image(systemName: "trash.fill")
                                    .tint(.red)
                            }
                        }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("List")
            .toolbar{
                Button {
                    // Action
                    viewModel.showAddItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showAddItemView){
                AddItem(addItemPresented: $viewModel.showAddItemView)
            }
        }
    }
}

#Preview {
    // default user id
    ItemList(userId: "JQVEb57P6CaXYr6PWNjzZioODLt2")
}
