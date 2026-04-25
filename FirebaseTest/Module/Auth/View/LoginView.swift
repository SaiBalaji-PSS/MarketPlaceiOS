//
//  LoginView.swift
//  FirebaseTest
//
//  Created by Saibalaji on 24/04/26.
//

import SwiftUI


struct LoginView: View {
    enum FieldType {
        case email
        case password
    }
    
    @EnvironmentObject var authVM: AuthViewModel
    
    
    @State private var email: String = ""
    @State private var password: String = ""
    @FocusState var field: FieldType?
    var fields = [FieldType.email,FieldType.password]
    @State private var selectedFieldIndex: Int = 0
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing:48){
                    Image(.firebase)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100,height: 100)
                    VStack(spacing:28){
                        
                        CustomTextField(placeHolderText: "Email", text: $email)
                            .focused($field, equals: .email)
                        CustomTextField(placeHolderText: "Password", text: $password)
                            .focused($field, equals: .password)
                        
                        CustomButton(title: "Login") {
                            Task{
                                await authVM.signIn(email: email, password: password)
                            }
                        }
                        NavigationLink {
                            RegisterView()
                        } label: {
                            Text("Don't have an account? Sign Up")
                                .tint(.yellow)
                        }
                        
                        
                    }.padding(.horizontal)
                    
                    
                }
            }
            .alert("Info", isPresented: $authVM.showMessage, actions: {
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
            .toolbarVisibility(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel(service: FirebaseAuthService()))
}
