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
    let dayImageUrl = "https://firebasestorage.googleapis.com/v0/b/list-3cbbb.appspot.com/o/day_streak.png?alt=media&token=9df323f2-0605-4cb7-8cfe-d2e86d63dabb&_gl=1*lo4a7y*_ga*MTA5OTE3NzMxNi4xNjk1ODM3NTY4*_ga_CW55HF8NVT*MTY5NzE3NzAzNC4xOC4xLjE2OTcxNzczMDYuNjAuMC4w"
    
    let weekImageUrl = "https://firebasestorage.googleapis.com/v0/b/list-3cbbb.appspot.com/o/week_streak.png?alt=media&token=751232b8-450a-49a6-818c-997716630d76&_gl=1*yol62c*_ga*MTA5OTE3NzMxNi4xNjk1ODM3NTY4*_ga_CW55HF8NVT*MTY5NzE3NzAzNC4xOC4xLjE2OTcxNzc3MDcuMTcuMC4w"
    
    let monthImageUrl = "https://firebasestorage.googleapis.com/v0/b/list-3cbbb.appspot.com/o/month_streak.png?alt=media&token=13820686-fbc0-4062-aed4-86feaeb25890&_gl=1*f58wgu*_ga*MTA5OTE3NzMxNi4xNjk1ODM3NTY4*_ga_CW55HF8NVT*MTY5NzE3NzAzNC4xOC4xLjE2OTcxNzc2NjQuNjAuMC4w"
    
    let yearImageUrl = "https://firebasestorage.googleapis.com/v0/b/list-3cbbb.appspot.com/o/year_streak.png?alt=media&token=058d48cd-7bd5-44f9-85d0-620ce544389b&_gl=1*hklnmv*_ga*MTA5OTE3NzMxNi4xNjk1ODM3NTY4*_ga_CW55HF8NVT*MTY5NzE3NzAzNC4xOC4xLjE2OTcxNzc2ODUuMzkuMC4w"
    
    
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
                
                var imageUrl = ""
                if (currentStreak! >= 365) {
                    imageUrl = self.yearImageUrl
                } else if (currentStreak! >= 30) {
                    imageUrl = self.monthImageUrl
                } else if (currentStreak! >= 7) {
                    imageUrl = self.weekImageUrl
                } else if (currentStreak! >= 1){
                    imageUrl = self.dayImageUrl
                }

                transaction.updateData(["streak": currentStreak ?? 0, "images": FieldValue.arrayUnion([imageUrl])], forDocument: userDocRef)

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
