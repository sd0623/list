//
//  Profile.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import SwiftUI

struct Profile: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView{
            
            VStack {
//                Header(size: 30.0, height: 100)
//                    .offset(y: -90)
                
                Text("Welcome to your account!")
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    Profile()
}
