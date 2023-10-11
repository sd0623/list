//
//  Login.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import SwiftUI

struct Login: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                Header(size: 80.0, height: 200)
                    .offset(y: -50)
                
                // Login Form
                Form {
                    if !viewModel.errorMsg.isEmpty {
                        Text(viewModel.errorMsg)
                            .foregroundColor(.red)
                    }
                    
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    ListButton(
                        title: "Log In",
                        bgColor: .blue
                    ) {
                        // Log in action
                        viewModel.login()
                    }
                    .padding()
                    
                }
//                .scrollContentBackground(.hidden)
                
                // Register
                VStack {
                    Text("Don't have an account?")
                    NavigationLink("Register", destination: Register())
                }
                .padding(.bottom, 50)
                
                Spacer()
                
            }
        }
        
    }
}

#Preview {
    Login()
}
