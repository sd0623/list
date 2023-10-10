//
//  Header.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import SwiftUI

struct Header: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(Color.gray)
                .opacity(0.4)
            
            VStack {
                HStack {
                    Image(systemName: "checkmark")
                        .font(.system(size: 80))
                        .foregroundColor(.accentColor)
                    
                    Text("List")
                        .font(.system(size: 80))
                        .foregroundColor(.accentColor)
                        .bold()
                }
                
            }
            .padding(.top, 50)
            .padding(.bottom, 20)
        }
        .frame(width: UIScreen.main.bounds.width,
               height: 200)
        .offset(y: -50)
    }
}

#Preview {
    Header()
}
