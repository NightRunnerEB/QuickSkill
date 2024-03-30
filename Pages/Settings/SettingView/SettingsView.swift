//
//  SettingsView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 23.02.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var isShowingProfile = false
    @State private var isShowingPassword = false
    @State private var isShowingGoal = false
    @State private var isShowingDelete = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Settings🛠️")
                    .font(
                        Font.Poppins(size: 22)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
                    .padding(.leading, 40)
                
                Spacer()
            }
            .padding(.top, 60)
            .padding(.bottom, 25)
            
            
            VStack {
                Button(action: {
                    isShowingProfile = true
                }, label: {
                    Image("Profile")
                        .resizable()
                        .frame(width: 19, height: 25)
                    Text("Profile")
                        .font(Font.Poppins(size: 20))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.black)
                })
                .fullScreenCover(isPresented: $isShowingProfile) {
                    ProfileSettingsView()
                }
                .padding(.bottom, 20)
                
                Button(action: {
                    isShowingPassword = true
                }, label: {
                    Image("Password")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Password")
                        .font(Font.Poppins(size: 20))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.black)
                })
                .fullScreenCover(isPresented: $isShowingPassword) {
                    ChangePasswordView()
                }
                .padding(.bottom, 20)
                
                Button(action: {
                    isShowingGoal = true
                }, label: {
                    Image("Goal_settings")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Goal settings")
                        .font(Font.Poppins(size: 20))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.black)
                })
                .fullScreenCover(isPresented: $isShowingGoal) {
                    GoalSettingView()
                }
                .padding(.bottom, 20)
                
                Button(action: {
                    isShowingDelete = true
                }, label: {
                    Image("Delete")
                        .resizable()
                        .frame(width: 18, height: 22)
                    Text("Delete account")
                        .font(Font.Poppins(size: 20))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.black)
                })
                .fullScreenCover(isPresented: $isShowingDelete) {
                    DeleteAccountView()
                }
                
            }
            .padding()
            .frame(width: 340, height: 226.30)
            .background(Color("Block"))
            .cornerRadius(15)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 6, y: 5)
            
            HStack {
                Text("Came across any problems?")
                  .font(Font.Poppins(size: 17).weight(.medium))
                
                NavigationLink(destination: ContactUsView()) {
                    Text("Contact us")
                        .font(Font.Poppins(size: 17).weight(.medium))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 120, height: 42)
                        .background(Color("Purple"))
                        .cornerRadius(15)
                }
            }
            .padding(.top, 20)
            
            Spacer()
        }
    }
}

#Preview {
    SettingsView()
}
