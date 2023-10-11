//
//  AddItemViewModel.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import Foundation

class AddItemViewModel: ObservableObject {
    @Published var title = ""
    @Published var dueDate = Date()
    
    @Published var showAlert = false
    
    init() {}
    
    func add() {
        
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
