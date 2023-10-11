//
//  ItemListViewModel.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import Foundation

/// ViewModel for list of items
/// Primary tab
class ItemListViewModel: ObservableObject {
    @Published var showAddItemView = false
    
    init() {}
}
