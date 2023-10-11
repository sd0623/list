//
//  AddItemViewModel.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class AddItemViewModel: ObservableObject {
    @Published var title = ""
    @Published var dueDate = Date()
    
    @Published var showAlert = false
    
    init() {}
    
    func add() {
        guard canAdd else {
            return
        }
        
        // Get current user
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Create model
        let newId = UUID().uuidString
        let newItem = ItemModel(
            id: newId,
            title: title,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false
        )
        
        // Save model (sub collection of current user)
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("tasks")
            .document(newId)
            .setData(newItem.asDictionary())
    }
    
    var canAdd: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        // seconds in day
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true
    }
}
