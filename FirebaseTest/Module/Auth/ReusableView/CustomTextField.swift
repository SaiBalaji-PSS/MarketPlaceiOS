//
//  CustomTextField.swift
//  FirebaseTest
//
//  Created by Saibalaji on 24/04/26.
//

import SwiftUI

struct CustomTextField: View {
    let placeHolderText: String
    @Binding var text: String
    
    var body: some View {
        ZStack{

                HStack{
                    TextField(placeHolderText, text: $text)
                }.padding().background(.lightGray).clipShape(RoundedRectangle(cornerRadius: 4.0))
            
        }
    }
}

#Preview {
    CustomTextField(placeHolderText: "Email",text: .constant(""))
}
