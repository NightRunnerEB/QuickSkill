//
//  LogInView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 19.02.2024.
//

import SwiftUI

struct LogInView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State var email: String = ""
    @State var password: String = ""
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email
        case password
    }
    
    var body: some View {
        VStack(spacing: 10) {
          VStack(spacing: 8) {
            Text("👋")
              Text("Welcome Back!")
              .font(Font.custom("Poppins", size: 17).weight(.medium))
              .foregroundColor(.black)
          }
        }
        .padding(16)
        .frame(width: 308, height: 88)
        .background(Color("Block"))
        .cornerRadius(24)
        .padding(.top, 60)
        
        Spacer()
        
        VStack {
            HStack() {
                TextField("Email", text: $email)
                    .focused($focusedField, equals: .email)
                    .keyboardType(.emailAddress)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .password }
                    .onChange(of: email) { newValue in
                        email = newValue.lowercased()
                    }
                    .font(Font.custom("Poppins", size: 17))
                
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
            
            Text("👋\nWelcome Back!")
                .font(Font.custom("Poppins", size: 17).weight(.medium))
                .multilineTextAlignment(.center)
                .lineSpacing(5)
                .foregroundColor(.black)
                .padding(16)
                .frame(width: 308, height: 88)
                .background(Color("Block"))
                .cornerRadius(24)
                .padding(.top, 60)
            
            Spacer()
            
            VStack {
                HStack() {
                    TextField("Email", text: $email)
                        .focused($focusedField, equals: .email)
                        .keyboardType(.emailAddress)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .password }
                        .font(Font.custom("Poppins", size: 17))
                    
                    if !email.isEmpty {
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
        }
        
        Spacer()
        
        if userVM.isLoading {
            ProgressView()
                .lineSpacing(18)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 15, leading: 33, bottom: 15, trailing: 33))
                .frame(width: 132, height: 48)
                .background(Color.white)
                .cornerRadius(24)
        } else {
            Button(action: {
                focusedField = nil // Скрыть клавиатуру
                userVM.login(email: email, password: password)
            }, label: {
                HStack(spacing: 10) {
                  Text("Log in")
                    .font(Font.custom("Poppins", size: 17).weight(.semibold))
                    .lineSpacing(18)
                    .foregroundColor(.white)
                }
                .padding(EdgeInsets(top: 15, leading: 33, bottom: 15, trailing: 33))
                .frame(width: 132, height: 48)
                .background(Color(red: 0.41, green: 0.05, blue: 0.92))
                .cornerRadius(24)
            })
            .disabled(email.isEmpty || password.isEmpty)
        }

        if let errorMessage = userVM.errorMessage {
            Text(errorMessage)
                .foregroundColor(.red)
        }
    }
}

#Preview {
    LogInView(email: "почта", password: "qwerty")
}
