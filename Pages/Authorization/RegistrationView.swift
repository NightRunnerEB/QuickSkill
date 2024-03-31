//
//  SignUpView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 19.02.2024.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject private var userVM: UserViewModel
    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) var dismiss
    @Binding var isShowingLogIn: Bool
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State private var confirmPassword = ""
    
    enum Field {
        case firstName
        case lastName
        case email
        case password
        case confirmPassword
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    HStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(Image(systemName: "chevron.left"))
                            .frame(width: 20, height: 20)
                        Text("Back")
                            .font(Font.Poppins(size: 16))
                            .foregroundColor(Color("Purple"))
                    }
                    .frame(width: 60, height: 20)
                })
                .padding(.leading, 15)
                
                Spacer()
            }
            
            VStack(spacing: 10) {
                VStack(spacing: 8) {
                    Text("🚀")
                    Text("Create new account")
                        .font(Font.custom("Poppins", size: 17).weight(.medium))
                        .foregroundColor(.black)
                    Text("Your learning journey will be started right after creating account")
                        .multilineTextAlignment(.center)
                        .font(Font.custom("Poppins", size: 14).weight(.light))
                        .foregroundColor(.black)
                }
            }
            .padding(16)
            .frame(width: 308, height: 128)
            .background(Color(red: 0.93, green: 0.93, blue: 0.93).opacity(0.80))
            .cornerRadius(24)
            .padding(.top, 60)
            
            Spacer()
            VStack {
                HStack() {
                    TextField("First name", text: $firstName)
                        .focused($focusedField, equals: .firstName)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .lastName }
                        .font(Font.custom("Poppins", size: 17))
                    
                    if(!firstName.isEmpty) {
                        Button(action: {
                            firstName = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.small)
                                .foregroundStyle(Color.gray)
                        })
                    }
                }
                .padding(.horizontal, 17)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 365, height: 0.7)
                    .background(Color(red: 0.78, green: 0.78, blue: 0.78))
                    .padding(.bottom, 35)
            }
            
            VStack {
                HStack() {
                    TextField("Last name", text: $lastName)
                        .focused($focusedField, equals: .lastName)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .email }
                        .font(Font.custom("Poppins", size: 17))
                    
                    if(!lastName.isEmpty) {
                        Button(action: {
                            lastName = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.small)
                                .foregroundStyle(Color.gray)
                        })
                    }
                }
                .padding(.horizontal, 17)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 365, height: 0.7)
                    .background(Color(red: 0.78, green: 0.78, blue: 0.78))
                    .padding(.bottom, 35)
            }
            
            VStack {
                HStack() {
                    TextField("Email", text: $email)
                        .focused($focusedField, equals: .email)
                        .keyboardType(.emailAddress)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .password }
                        .font(Font.custom("Poppins", size: 17))
                    
                    if(!email.isEmpty) {
                        Button(action: {
                            email = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.small)
                                .foregroundStyle(Color.gray)
                        })
                    }
                    
                }
                .padding(.horizontal, 17)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 365, height: 0.7)
                    .background(Color(red: 0.78, green: 0.78, blue: 0.78))
                    .padding(.bottom, 35)
            }
            
            VStack {
                HStack() {
                    SecureField("Password", text: $password)
                        .focused($focusedField, equals: .password)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .confirmPassword }
                        .font(Font.custom("Poppins", size: 17))
                    
                    if(!password.isEmpty) {
                        Button(action: {
                            password = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.small)
                                .foregroundStyle(Color.gray)
                        })
                    }
                }
                .padding(.horizontal, 17)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 365, height: 0.7)
                    .background(Color(red: 0.78, green: 0.78, blue: 0.78))
                    .padding(.bottom, 35)
            }
            
            VStack {
                HStack() {
                    SecureField("Confirm password", text: $confirmPassword)
                        .focused($focusedField, equals: .confirmPassword)
                        .submitLabel(.done)
                        .font(Font.custom("Poppins", size: 17))
                    
                    if(!confirmPassword.isEmpty) {
                        Button(action: {
                            confirmPassword = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.small)
                                .foregroundStyle(Color.gray)
                        })
                    }
                }
                .padding(.horizontal, 17)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 365, height: 0.7)
                    .background(Color(red: 0.78, green: 0.78, blue: 0.78))
            }
            
            Spacer()
            
            
            Button(action: {
                focusedField = nil // Скрыть клавиатуру
                userVM.register(firstName: firstName, lastName: lastName, email: email, password: password)
                if(userVM.isRegistered) {
                    isShowingLogIn = true
                    dismiss()
                }
            }, label: {
                HStack(spacing: 10) {
                    Text("Sign Up")
                        .font(Font.custom("Poppins", size: 17).weight(.semibold))
                        .lineSpacing(18)
                        .foregroundColor(.white)
                }
                .padding(EdgeInsets(top: 15, leading: 33, bottom: 15, trailing: 33))
                .frame(width: 132, height: 48)
                .background(Color(red: 0.41, green: 0.05, blue: 0.92))
                .cornerRadius(24)
            })
            
            if(confirmPassword != password) {
                Text("Different passwords have been entered!")
                    .foregroundColor(.red)
            }
        }
    }
}
