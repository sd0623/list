//
//  listApp.swift
//  list
//
//  Created by Sathwika Deegutla on 10/9/23.
//

import FirebaseCore
import SwiftUI

@main
struct listApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            Main()
        }
    }
}
