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
                
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Loading Profile...")
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        // Avatar
        Image(systemName: "person.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .frame(width: 125, height: 125)
            .padding()
        
        // Info: Name, Email, Joined since
        VStack(alignment: .leading){
            HStack {
                Text("Name: ")
                    .bold()
                Text(user.name)
            }
            .padding()
            .font(.system(size: 20))
            
            HStack {
                Text("Email: ")
                    .bold()
                Text(user.email)
            }
            .padding()
            .font(.system(size: 20))
            
            HStack {
                Text("Joined: ")
                    .bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
            .padding()
            .font(.system(size: 20))
            
//            HStack {
//                Text("Streak: ")
//                    .bold()
//                Text(String(user.streak))
//            }
//            .padding()
//            .font(.system(size: 20))
//            
            // Display images
            
        }
        .padding()
        
        // Log out
        Form {
            ListButton(title: "Log Out", bgColor: .red){
                viewModel.logout()
            }
        }
        .padding()
        .scrollContentBackground(.hidden)
        
        Spacer()
    }
}

#Preview {
    Profile()
}
