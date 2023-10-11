//
//  ItemModel.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import Foundation

struct ItemModel: Codable, Identifiable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    
    // since this is struct
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
