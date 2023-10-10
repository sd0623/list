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
            ItemList()
        } else {
            Login()
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
