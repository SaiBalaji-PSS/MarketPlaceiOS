//
//  CustomPasswordField.swift
//  FirebaseTest
//
//  Created by Saibalaji on 24/04/26.
//

import SwiftUI

struct CustomPasswordField: View {
    let placeholderText: String
    @Binding var text: String
    @State private var showSecureField: Bool = false
    var body: some View {
        ZStack{
            if showSecureField == false{
                HStack{
                    TextField(placeholderText, text: $text)
                    Button {
                        self.showSecureField.toggle()
                    } label: {
                        Image(systemName: "eye.slash")
                            .tint(.black)
                    }
                    
                }.padding().background(.lightGray).clipShape(RoundedRectangle(cornerRadius: 4.0))
            }
            else{
                HStack{
                    SecureField(placeholderText, text: $text)
                    Button {
                        self.showSecureField.toggle()
                    } label: {
                        Image(systemName: "eye")
                            .tint(.black)
                    }
                    
                }.padding().background(.lightGray).clipShape(RoundedRectangle(cornerRadius: 4.0))
            }
        }
    }
}

#Preview {
    CustomPasswordField(placeholderText: "Password", text: .constant(""))
}
