//
//  ItemViewModel.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

/// ViewModel for each item
/// Secondary tab
class ItemViewModel: ObservableObject {
    init() {}
            
    func toggleIsDone(task: ItemModel) {
        print("toggle")
        var taskCopy = task
        taskCopy.setDone(!task.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("tasks")
            .document(taskCopy.id)
            .setData(taskCopy.asDictionary())
            
    }

}
