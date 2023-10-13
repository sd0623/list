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
            .frame(width: 100, height: 100)
            .padding()
        
        // Info: Name, Email, Joined since
        VStack(alignment: .leading){
            HStack {
                Text("Name: ")
                    .bold()
                Text(user.name)
            }
            .padding(.bottom, 10)
            .font(.system(size: 20))
            
            HStack {
                Text("Email: ")
                    .bold()
                Text(user.email)
            }
            .padding(.bottom, 10)
            .font(.system(size: 20))
            
            HStack {
                Text("Joined: ")
                    .bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
            .padding(.bottom, 10)
            .font(.system(size: 20))
            
            HStack {
                Text("Streak: ")
                    .bold()
                Text(String(user.streak))
            }
            .padding(.bottom, 10)
            .font(.system(size: 20))
          
            // Display images
            HStack {
                ForEach(user.images, id: \.self) { imageURL in
                    if let url = URL(string: imageURL) {
                        RemoteImage(url: url)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80) // Adjust the size as needed
                    }
                }
            }
            
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

struct RemoteImage: View {
    let url: URL

    var body: some View {
        if let data = try? Data(contentsOf: url),
           let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        } else {
            // Placeholder image or error handling
            Text("Image Loading Error")
        }
    }
}

#Preview {
    Profile()
}
