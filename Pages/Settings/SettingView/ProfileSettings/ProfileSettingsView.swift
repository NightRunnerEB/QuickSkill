//
//  ProfileSettingsView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 23.02.2024.
//

import SwiftUI

struct ProfileSettingsView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
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
                    Image("Profile")
                        .resizable()
                        .frame(width: 22, height: 28)
                        .padding(.leading, 14)
                    Text("Profile")
                        .font(
                            Font.Poppins(size: 23)
                                .weight(.medium)
                        )
                    
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("First name")
                        .font(Font.Poppins(size: 21).weight(.medium))
                    
                    HStack {
                        
                        TextField("First name", text: $userVM.user.firstName)
                        
                        Image(systemName: "checkmark.shield")
                            .foregroundStyle(Color.green)
                        
                    }
                    .padding()
                    .frame(width: 369, height: 50)
                    .background(Color("Block"))
                    .cornerRadius(15)
                    .padding(.bottom, 20)
                    
                    Text("Last name")
                        .font(Font.Poppins(size: 21).weight(.medium))
                    HStack {
                        
                        TextField("Lastname", text: $userVM.user.lastName)
                        
                        Image(systemName: "checkmark.shield")
                            .foregroundStyle(Color.green)
                        
                    }
                    .padding()
                    .frame(width: 369, height: 50)
                    .background(Color("Block"))
                    .cornerRadius(15)
                    .padding(.bottom, 20)
                    
                    Text("Username")
                        .font(Font.Poppins(size: 21).weight(.medium))
                    
                    HStack {
                        
                        TextField("Username", text: $userVM.user.username)
                        
                        Image(systemName: "checkmark.shield")
                            .foregroundStyle(Color.green)
                        
                    }
                    .padding()
                    .frame(width: 369, height: 50)
                    .background(Color("Block"))
                    .cornerRadius(15)
                    .padding(.bottom, 20)
                    
                    Text("Photo")
                        .font(Font.Poppins(size: 21).weight(.medium))
                    
                    HStack(spacing: 20) {
                        if let photo = userVM.user.photo {
                            AsyncImage(url: URL(string: photo)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        }
                        VStack {
                            Button(action: {
                                // загрузка фото
                            }, label: {
                                HStack(spacing: 2) {
                                    Text("Upload")
                                        .font(Font.Poppins(size: 14))
                                    Image("Upload")
                                }
                                .padding()
                                .frame(width: 100, height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("Purple"), lineWidth: 2)
                                )
                            })
                            
                            Text("JPG or PNG\nMax size - 900 KB")
                                .font(Font.Poppins(size: 12))
                            
                        }
                    }
                    
                    Text("Bio")
                        .font(Font.Poppins(size: 21).weight(.medium))
                        .padding(.top, 12)
                    
                    
                    TextField("Information about you", text: $userVM.user.description)
                        .padding()
                        .frame(width: 369, height: 130)
                        .background(Color("Block"))
                        .cornerRadius(15)
                    
                }
                
                Button(action: {
                    dismiss()
                }, label: {
                    HStack(spacing: 10) {
                        Text("Сохранить")
                            .font(Font.Poppins(size: 12).weight(.medium))
                            .foregroundColor(.white)
                    }
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .background(Color("Purple"))
                    .cornerRadius(15)
                })
            }
        }
        .padding(.top, 1)
    }
}

#Preview {
    ProfileSettingsView()
        .environmentObject(UserViewModel())
}
