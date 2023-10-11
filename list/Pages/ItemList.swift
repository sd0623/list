//
//  ItemList.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import SwiftUI

struct ItemList: View {
    @StateObject var viewModel = ItemListViewModel()
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    var body: some View {
        NavigationView{
            
            VStack {
//                Header(size: 30.0, height: 100)
//                    .offset(y: -90)
                
                Text("Welcome to your account!")
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
    ItemList(userId: "")
}
