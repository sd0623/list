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
    var user: User?
    
    init() {}
            
    func toggleIsDone(task: ItemModel) {
        print("toggle")
        var taskCopy = task
        taskCopy.setDone(!task.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.runTransaction { (transaction, errorPointer) -> Any? in
            do {
                let userDocRef = db.collection("users").document(uid)
                let taskDocRef = userDocRef.collection("tasks").document(task.id)

                // Get user data
                let userSnapshot = try transaction.getDocument(userDocRef)
                guard let userData = userSnapshot.data() else {
                    return nil
                }

                self.user = User(
                    id: userData["id"] as? String ?? "",
                    name: userData["name"] as? String ?? "",
                    email: userData["email"] as? String ?? "",
                    joined: userData["joined"] as? TimeInterval ?? 0,
                    streak: userData["streak"] as? Int ?? 0,
                    images: userData["images"] as? [String] ?? [""]
                )

                // Update the task
                var taskCopy = task
                taskCopy.setDone(!task.isDone)
                transaction.setData(taskCopy.asDictionary(), forDocument: taskDocRef)

                // Update the streak
                let taskDone = taskCopy.isDone
                var currentStreak = self.user?.streak

                if taskDone {
                    currentStreak = currentStreak! + 1
                } else {
                    currentStreak = currentStreak! - 1
                }
                
                

                transaction.updateData(["streak": currentStreak ?? 0], forDocument: userDocRef)

                return nil
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }
        } completion: { (_, error) in
            if let error = error {
                print("Transaction failed with error: \(error)")
            }
        }
        
       
    }

}
