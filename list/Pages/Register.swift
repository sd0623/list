//
//  Register.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import SwiftUI

struct Register: View {
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        VStack {
            // Header
            Header(size: 80.0, height: 200)
                .offset(y: -90)
            
            // Register form
            Form {
                if !viewModel.errorMsg.isEmpty {
                    Text(viewModel.errorMsg)
                        .foregroundColor(.red)
                }
                
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                ListButton(
                    title: "Register",
                    bgColor: .blue
                ) {
                    // register action
                    viewModel.register()
                }
                .padding()
                
            }
            
            Spacer()
        }
        
    }
}

#Preview {
    Register()
}
