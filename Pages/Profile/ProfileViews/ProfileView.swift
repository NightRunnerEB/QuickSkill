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
    
    var body: some View {
        
        Group {
            if userVM.user != nil {
                NavigationView {
                    ScrollView {
                        VStack(spacing: 12) {
                            HStack(alignment: .top) {
                                Spacer()
                                
                                if let photo = userVM.user.photo {
                                    AsyncImage(url: URL(string: photo)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 64, height: 64)
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                } else {
                                    Image(systemName: "person.circle")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 34, height: 34)
                                        .clipShape(Circle())
                                }
                                
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
                                
                                Text("0 followers")
                                
                                Spacer()
                                
                                Image("User Account")
                                
                                Text("0 followings")
                                
                                Spacer()
                            }
                            
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 296, height: 1)
                            
                            Image("Aqua Horizon")
                                .resizable()
                                .frame(width: 58, height: 58)
                            
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
                                CalendarCardView(streak: userVM.user.streak, streakRecord: userVM.user.maxStreak)
                                
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
                        
                        ForEach($courseVM.userCourses, id: \.id) { $course in
                            HStack {
                                Image(course.media)
                                    .resizable()
                                    .frame(width: 55, height: 55)
                                
                                VStack {
                                    Text(course.name)
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
                    .refreshable{
                        userVM.getInfo()
                        courseVM.getUserCourses()
                    }
                }
            } else {
                Text(userVM.errorMessage!)
            }
        }
        .padding(.top, 1)
        .onAppear {
            userVM.getInfo()
            courseVM.getUserCourses()
        }
    }
}

#Preview {
    @State var sel = false
    return ProfileView()
        .environmentObject(UserViewModel())
}
