//
//  CustomButton.swift
//  FirebaseTest
//
//  Created by Saibalaji on 24/04/26.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    var btnClicked: (() -> (Void))?
    var body: some View {
        Button {
            btnClicked?()
        } label: {
            Text(title)
                .tint(.white)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(.yellow)
               
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
        }

    }
}

#Preview {
    CustomButton(title: "Login") {
        
    }
}
