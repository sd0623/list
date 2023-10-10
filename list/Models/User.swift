//
//  User.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
