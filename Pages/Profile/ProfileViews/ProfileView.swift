//
//  ProfileView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 20.02.2024.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userVM: UserViewModel
    @StateObject var courseVM = CourseViewModel()
    @Binding var selectedTab: String // Добавляем привязку к выбранной вкладке
    
    var body: some View {
        
        Group {
            NavigationView {
                ScrollView {
                    VStack(spacing: 12) {
                        HStack(alignment: .top) {
                            Spacer()
                            
                            Image(userVM.user.photo)
                                .resizable()
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .frame(width: 64, height: 64)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text(userVM.user.firstName + " " + userVM.user.lastName)
                                    .font(Font.Poppins(size: 19).weight(.semibold))
                                
                                Text(userVM.user.username)
                                    .font(Font.Poppins(size: 14))
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: SettingsView(), label: {
                                Image("Gear")
                                    .resizable()
                                    .frame(width: 41, height: 33)
                            })
                            .padding(-6)
                        }
                        .padding(.bottom, 4)
                        
                        HStack(spacing: 4) {
                            Spacer()
                            
                            Image("User Account")
                            
                            Text("\(userVM.user.followers) followers")
                            
                            Spacer()
                            
                            Image("User Account")
                            
                            Text("\(userVM.user.followings) followings")
                            
                            Spacer()
                        }
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: 296, height: 1)
                        
                        HStack {
                            Image("Vector")
                                .resizable()
                                .frame(width: 15, height: 15)
                            
                            Text("\(userVM.user.xp) XP")
                                .font(Font.custom("Poppins", size: 15))
                        }
                        
                    }
                    .padding(16)
                    .frame(width: 328, height: 264)
                    .background(Color("Block"))
                    .cornerRadius(24)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            CalendarCardView(streak: userVM.user.streak, streakRecord: userVM.user.streakRecord)
                            
                            QuickyCardView(experience: userVM.user.xp)
                            
                            CertificatesCardView()
                            
                            BadgesCardView()
                        }
                        .padding()
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 12)
                    
                    VStack(spacing: 10) {
                        
                        NavigationLink(destination: FindPeopleView(), label: {
                            HStack {
                                Image("Search")
                                
                                Text("Find people")
                                    .font(Font.Poppins(size: 17).weight(.semibold))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                        })
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: 310, height: 1)
                        
                        NavigationLink(destination: ShopView(), label: {
                            HStack {
                                Image("Shop")
                                
                                Text("Shop")
                                    .font(Font.Poppins(size: 17).weight(.semibold))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                        })
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: 310, height: 1)
                        
                        NavigationLink(destination: SettingsView(), label: {
                            HStack {
                                Image("Setting")
                                
                                Text("Settings")
                                    .font(Font.Poppins(size: 17).weight(.semibold))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                        })
                    }
                    .accentColor(.black)
                    .padding(16)
                    .frame(width: 375, height: 220)
                    .background(Color("Block"))
                    .cornerRadius(24)
                    .padding(.bottom, 28)
                    
                    ForEach($courseVM.courses, id: \.id) { course in
                            HStack {
                                Image(course.media.wrappedValue)
                                    .resizable()
                                    .frame(width: 55, height: 55)
                                
                                VStack {
                                    Text(course.name.wrappedValue)
                                        .font(Font.custom("Poppins", size: 17).weight(.semibold))
                                    
                                    Text("In progress")
                                        .font(Font.custom("Poppins", size: 12))
                                    
                                }
                                
                                Spacer()
                                
                                NavigationLink(destination: CourseView(course: course), label: {
                                    HStack(spacing: 10) {
                                        Text("Start")
                                            .font(Font.custom("Poppins", size: 17).weight(.semibold))
                                            .lineSpacing(20)
                                            .foregroundColor(.black)
                                    }
                                    .padding(EdgeInsets(top: 8, leading: 32, bottom: 8, trailing: 32))
                                    .frame(width: 106, height: 36)
                                    .background(.white)
                                    .cornerRadius(24)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 24)
                                            .inset(by: -0.25)
                                            .stroke(
                                                Color(red: 0, green: 0, blue: 0).opacity(0.04), lineWidth: 0.25
                                            )
                                    )
                                    .shadow(
                                        color: Color(red: 0, green: 0, blue: 0, opacity: 0.14), radius: 2, y: 3
                                    )
                                })
                            }
                            .padding(16)
                            .frame(width: 375, height: 72)
                            .background(Color("Block"))
                            .cornerRadius(24)
                    }
                }
            }
        }
        .onAppear {
            userVM.getInfo()
            courseVM.getCourses()
        }
    }
}
