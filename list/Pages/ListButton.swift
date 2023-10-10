//
//  ListButton.swift
//  list
//
//  Created by Sathwika Deegutla on 10/10/23.
//

import SwiftUI

struct ListButton: View {
    let title: String
    let bgColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundColor(bgColor)
                Text(title)
                    .foregroundColor(.white)
                    .bold()
                    .padding(5)
            }
        }
    }
}

#Preview {
    ListButton(title: "Button", bgColor: .blue) {
        // Action
    }
}
