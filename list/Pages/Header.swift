//
//  Header.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import SwiftUI

struct Header: View {
    let size: Double
    let height: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(Color.gray)
                .opacity(0.4)
            
            VStack {
                HStack {
                    Image(systemName: "checkmark")
                        .font(.system(size: size))
                        .foregroundColor(.accentColor)
                    
                    Text("List")
                        .font(.system(size: size))
                        .foregroundColor(.accentColor)
                        .bold()
                }
                
            }
            .padding(.top, 40)
        }
        .frame(width: UIScreen.main.bounds.width,
               height: height)
    }
}

#Preview {
    Header(size: 30.0, height: 100.0)
}
