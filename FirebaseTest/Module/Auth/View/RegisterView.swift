//
//  RegisterView.swift
//  FirebaseTest
//
//  Created by Saibalaji on 24/04/26.
//

import SwiftUI

struct RegisterView: View {
    enum FieldType {
        case userName
        case email
        case password
        case confirmPassword
        
    }
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var userName: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authVM: AuthViewModel
    @State private var confirmPassword: String = ""
    
    @FocusState var field: FieldType?
    var fields = [FieldType.userName,FieldType.email,FieldType.password,FieldType.confirmPassword]
    
    @State private var selectedFieldIndex: Int = 0
    
    var body: some View {
        ScrollView{
            VStack(spacing:48){
                Image(.firebase)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100,height: 100)
                VStack(spacing:28){
                    
                    CustomTextField(placeHolderText: "Username", text: $userName)
                        .focused($field, equals: .userName)
                    CustomTextField(placeHolderText: "Email", text: $email)
                        .focused($field, equals: .email)
                    CustomTextField(placeHolderText: "Password", text: $password)
                        .focused($field, equals: .password)
                    CustomTextField(placeHolderText: "ConfirmPassword", text: $confirmPassword)
                        .focused($field, equals: .confirmPassword)
                    
                    
                    CustomButton(title: "Sign up") {
                        Task{
                            await self.authVM.signUp(email: email, password: password,userName: userName)
                        }
                    }
                    Button {
                        dismiss()
                    } label: {
                        Text("Already have an account? Login")
                            .tint(.yellow)
                    }
                    
                    
                    
                }.padding(.horizontal)
                
                
            }
        }  .alert("Info", isPresented: $authVM.showMessage, actions: {
            Button("OK"){
                
            }
            
        }, message: {
            Text(authVM.message)
        })
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    HStack{
                        Button {
                            // action 1
                            self.selectedFieldIndex = (self.selectedFieldIndex - 1) % self.fields.count
                            if self.selectedFieldIndex < 0{
                                self.selectedFieldIndex = 0
                            }
                            self.field = self.fields[selectedFieldIndex]
                            
                        } label: {
                            Image(systemName: "chevron.up")
                        }
                        
                        Button {
                            // action 2
                            self.selectedFieldIndex = (self.selectedFieldIndex + 1) % self.fields.count
                            
                            self.field = self.fields[selectedFieldIndex]
                            
                        } label: {
                            Image(systemName: "chevron.down")
                        }
                        Spacer()
                        Button {
                            self.field = nil
                        } label: {
                            Text("Done")
                        }
                    }

                }
            }
            
        
    }
}

#Preview {
    RegisterView()
        .environmentObject(AuthViewModel(service: FirebaseAuthService()))
}
