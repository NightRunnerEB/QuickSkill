//
//  DeleteAccountView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 23.02.2024.
//

import SwiftUI

struct DeleteAccountView: View {
    @AppStorage("isUserAuthenticated") var isUserAuthenticated: Bool = true
    @EnvironmentObject var userVM: UserViewModel
    @State private var isPasswordVisible = false
    @State private var userPassword = ""
    @Environment(\.dismiss) var dismiss
    
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
                    .padding(.leading, 10)
                    
                    Spacer()
                }
                
                HStack {
                    Image("Delete")
                        .resizable()
                        .frame(width: 19.80, height: 23.10)
                        .padding(.leading, 30)
                    Text("Delete account")
                        .font(
                            Font.Poppins(size: 22)
                                .weight(.medium)
                        )
                    
                    Spacer()
                }
                .padding(.top, 25)
                .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 29) {
                    Text("Are you sure?")
                        .font(Font.Poppins(size: 19).weight(.medium))
                        .lineSpacing(14.70)
                    
                    Text("The deleting of account is irreversible☠️ \nYou’ll lose:\n• all your progress\n• access to courses\n• your certificates")
                        .font(Font.Poppins(size: 15.30))
                    
                    Text("Money for unused time of PRO status won’t be refunded.")
                        .font(Font.Poppins(size: 15.30))
                    
                    LinkStringView()
                        .font(Font.Poppins(size: 15.30))
                    
                    Text("Otherwise, enter your password and confirm deletion below😞")
                        .font(Font.Poppins(size: 15.30))
                    
                    Text("Password")
                        .font(Font.Poppins(size: 19).weight(.medium))
                        .padding(.top, 15)
                    
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $userPassword)
                        } else {
                            SecureField("Password", text: $userPassword)
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }, label: {
                            Image(systemName: isPasswordVisible ? "eye.circle" : "eye.slash.circle")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundStyle(.black)
                        })
                        
//                        Image(systemName: userPassword == userVM.user.password ? "checkmark.shield" : "xmark.shield")
//                            .foregroundStyle(userPassword == userVM.user.password ? Color.green : Color.red)
                        
                    }
                    .padding()
                    .frame(width: 310.50, height: 46.80)
                    .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                    .cornerRadius(12.25)
                    
                    HStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 22, height: 22)
                            .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                            .cornerRadius(8.17)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(red: 0.41, green: 0.05, blue: 0.92), lineWidth: 0.41)
                            )
                        
                        Text("I understand that account deleting is irreversible process and I’ll lose all my achievements bla bla ")
                            .font(Font.Poppins(size: 12))
                    }
                    .padding(.leading, 5)
                    
                    
                    Button(action: {
                        self.isUserAuthenticated = false
                        // удалить аккаунт
                    }, label: {
                        Text("Delete")
                            .font(Font.Poppins(size: 17.15).weight(.medium))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 160, height: 40)
                            .background(Color("Delete-button"))
                            .cornerRadius(12.25)
                        
                    })
                    .padding(.leading, UIScreen.main.bounds.width / 5)
                    
                    
                }
                .padding()
                .frame(width: 340, height: 635)
                .background(Color("Block"))
                .cornerRadius(15)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 6, y: 5)
            }
    }
}

#Preview {
    DeleteAccountView()
        .environmentObject(UserViewModel())
}
