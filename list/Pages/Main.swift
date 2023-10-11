//
//  ContentView.swift
//  list
//
//  Created by Sathwika Deegutla on 10/9/23.
//

import SwiftUI

struct Main: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            // signed in, list view
            signedInView
        } else {
            Login()
        }
    }
    
    @ViewBuilder
    var signedInView: some View {
        TabView {
            ItemList(userId: viewModel.currentUserId)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Profile()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
