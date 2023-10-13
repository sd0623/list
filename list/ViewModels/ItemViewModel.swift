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
    
    @Published var user: User? = nil
    
    func toggleIsDone(task: ItemModel) {
        var taskCopy = task
        taskCopy.setDone(!task.isDone)
        
        var count = 0
        if (taskCopy.isDone) {
            count = 1
        } else {
            count = -1
        }
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        print("toggle")
        print("count: ", count)
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.user = User(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0,
                    streak: data["streak"] as? Int ?? 0,
                    images: data["images"] as? [String] ?? [""]
                )
            }
        }
        
        db.collection("users")
            .document(uid)
            .collection("tasks")
            .document(taskCopy.id)
            .setData(taskCopy.asDictionary())
        
        var total = (self.user?.streak ?? 0) + count
        print("total: ", total)
        db.collection("users")
            .document(uid)
            .setData(["streak": total], merge: true)
    }
}
