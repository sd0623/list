//
//  ItemListViewModel.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import FirebaseFirestore
import Foundation

/// ViewModel for list of items
/// Primary tab
class ItemListViewModel: ObservableObject {
    @Published var showAddItemView = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    /// Deletes a task
    /// - Parameter id: task id to delete
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("tasks")
            .document(id)
            .delete()
    }
}
