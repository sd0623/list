//
//  Login.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import SwiftUI

struct Login: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                Header()
                
                // Login Form
                Form {
                    TextField("Email", text: $email)
                        .textFieldStyle(DefaultTextFieldStyle())
                    SecureField("Password", text: $password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    Button {
                        // Log in
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            Text("Log In")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
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
