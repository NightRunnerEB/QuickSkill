//
//  MyHomeView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 20.02.2024.
//

import SwiftUI

struct MyHomeView: View {
    @EnvironmentObject var userVM: UserViewModel
    @State private var isShowingGoal = false
    @State private var isShowingGetPro = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: SettingsView(), label: {
                        Image("Gear")
                            .resizable()
                            .frame(width: 41, height: 33)
                    })
                }
                .padding(.trailing, 7)
                
                ScrollView {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color.white)
                        .frame(width: 358.81, height: 290)
                        .shadow(
                            color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 4, y: 4
                        )
                        .overlay(content: {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Text("Daily tasks")
                                        .font(Font.Poppins(size: 24))
                                    
                                    Spacer()
                                }
                                .padding()
                                
                                ForEach(DailyTask.allDailyTasks) { task in
                                    HStack {
                                        Image(task.icon)
                                            .resizable()
                                            .frame(width: 45, height: 45)
                                        
                                        VStack(alignment: .leading) {
                                            Text(task.description)
                                                .font(Font.Poppins(size: 15))
                                            
                                            HStack(spacing: 4) {
                                                Text("\(task.currentValue)/\(task.targetValue)")
                                                    .font(Font.custom("Inter", size: 9))
                                                
                                                ZStack(alignment: .leading) {
                                                    RoundedRectangle(cornerRadius: 25)
                                                        .frame(width: 177, height: 7.07)
                                                        .opacity(0.3)
                                                        .foregroundColor(Color.gray.opacity(0.5))
                                                    
                                                    RoundedRectangle(cornerRadius: 25)
                                                        .frame(width: CGFloat(task.currentValue / task.targetValue) * 177, height: 7.07)
                                                        .foregroundColor(Color("Success-scale"))
                                                        .animation(.linear, value: task.currentValue)
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.leading, 10)
                                
                                HStack {
                                    Spacer()
                                    
                                    Button(action: {
                                        isShowingGetPro = true
                                    }, label: {
                                        Text("Get x2 XP with Premium")
                                            .font(Font.custom("Inter", size: 12).weight(.semibold))
                                            .foregroundColor(.white)
                                            .frame(width: 150, height: 34.32)
                                            .background(Color("Subscribe"))
                                            .cornerRadius(10.5)
                                    })
                                    .fullScreenCover(isPresented: $isShowingGetPro, content: {
                                        GetProView()
                                    })
                                    
                                    Spacer()
                                }
                                
                            }
                        })
                    
                    
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color("Purple"))
                        .frame(width: 350, height: 160)
                        .overlay(
                            HStack {
                                
                                VStack(alignment: .leading) {
                                    
                                    Text("Your goal:")
                                        .font(Font.custom("Poppins", size: 23).weight(.medium))
                                        .foregroundColor(.white)
                                        .tracking(0.54)
                                        .padding(.bottom, 1)
                                    
                                    Text("\(userVM.user.goal.description)")
                                        .font(Font.custom("Poppins", size: 19))
                                        .foregroundColor(.white)
                                        .tracking(0.54)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        isShowingGoal = true
                                    }, label: {
                                        Text("Set the goal")
                                            .font(Font.custom("Inter", size: 17).weight(.medium))
                                            .foregroundColor(Color("Purple"))
                                            .frame(width: 115, height: 47)
                                            .background(.white)
                                            .cornerRadius(10.51)
                                    })
                                    .fullScreenCover(isPresented: $isShowingGoal, content: {
                                        GoalSettingView()
                                    })
                                }
                                
                                Spacer()
                                
                                VStack {
                                    Image("streak_ball")
                                        .resizable()
                                        .frame(width: 45.41, height: 57.23)
                                    
                                    Text("3/6")
                                        .fontWeight(.bold)
                                    
                                    Text("The path to mastery")
                                }
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: 98, height: 155.23)
                                .padding(.bottom, 5)
                            }
                                .padding()
                            
                        )
                        .padding()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image("Quickskill_small")
                            
                            Text("Your courses ")
                                .font(Font.custom("Inter", size: 24))
                        }
                        .padding(.leading, 20)
                        
                        ForEach(Array(userVM.user.coursesSuccess.keys), id: \.self) { courseID in
                            
                            let course = Course.allCourses[courseID]
                            
                            NavigationLink(destination: CourseView(course: course), label: {
                                HStack {
                                    Image(course.icon)
                                        .resizable()
                                        .frame(width: 55, height: 55)
                                    
                                    VStack(alignment: .leading) {
                                        Text(course.title)
                                            .font(Font.custom("Poppins", size: 15))
                                        
                                        HStack(spacing: 4) {
                                            Text("\(CGFloat(userVM.user.coursesSuccess[courseID]!) / (CGFloat( course.lecturesAndPractices.count) / 100), specifier: "%.0f")%")
                                                .font(Font.custom("Inter", size: 10))
                                            
                                            ZStack(alignment: .leading) {
                                                RoundedRectangle(cornerRadius: 25)
                                                    .frame(width: 177, height: 7.07)
                                                    .opacity(0.3)
                                                    .foregroundColor(Color.gray.opacity(0.5))
                                                
                                                RoundedRectangle(cornerRadius: 25)
                                                    .frame(width: CGFloat(userVM.user.coursesSuccess[courseID]!) / CGFloat(course.lecturesAndPractices.count) * 177, height: 7.07)
                                                    .foregroundColor(Color("Success-scale"))
                                            }
                                        }
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                }
                                .accentColor(.black)
                                .padding(16)
                                .frame(width: 355, height: 72)
                                .background(Color("Block"))
                                .cornerRadius(16)
                                
                            })
                        }
                    }
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(Color.white)
                            .frame(width: 360, height: 199.61)
                            .shadow(
                                color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 4, y: 4
                            )
                            .overlay(content: {
                                VStack(spacing: 8.40) {
                                    VStack(spacing: 0) {
                                        Image("Questions")
                                        
                                        Text("QuickSkill quiz")
                                            .font(Font.Poppins(size: 22).weight(.semibold))
                                            .foregroundColor(.black)
                                    }
                                    Text("Discover your perfect course with QuickSkill's personalized recommendation quiz – unlock your learning journey today! ")
                                        .font(Font.custom("Poppins", size: 17))
                                        .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.60))
                                        .multilineTextAlignment(.center)
                                }
                            })
                        
                        NavigationLink(destination: QuickSkillQuizView(), label: {
                            HStack(spacing: 10.51) {
                                Image("Quickskill_small")
                                    .resizable()
                                    .frame(width: 21, height: 21)
                                
                                Text("Get Started")
                                    .font(Font.custom("Inter", size: 17).weight(.semibold))
                                    .foregroundColor(Color("Purple"))
                            }
                            .padding(
                                EdgeInsets(top: 13.66, leading: 21.01, bottom: 13.66, trailing: 21.01)
                            )
                            .frame(width: 164.54, height: 50)
                            .background(Color(red: 0.41, green: 0.05, blue: 0.92).opacity(0.15))
                            .cornerRadius(10.51)
                        })
                        .padding(.top, 5)
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                        .frame(height: 30)
                    VStack {
                        HStack {
                            Text("Badges")
                                .font(Font.custom("Inter", size: 24).weight(.semibold))
                            
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [
                                GridItem(.flexible(), spacing: 5),
                                GridItem(.flexible(), spacing: 0),
                            ], spacing: 40, content: {
                                ForEach(Badge.allBadges) { item in
                                    HStack {
                                        if (userVM.user.badges.contains(where: { $0 == item.id})) {
                                            Image(item.icon)
                                                .resizable()
                                                .frame(width: 73, height: 73)
                                        } else {
                                            Image("Badge")
                                        }
                                        
                                        VStack {
                                            Text(item.name)
                                                .font(Font.custom("Inter", size: 18).weight(.semibold))
                                            
                                            Text(item.description)
                                                .font(Font.custom("Inter", size: 11))
                                                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.60))
                                        }
                                        .frame(width: 180, height: 65)
                                    }
                                    .frame(height: 100)
                                }
                            })
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    return MyHomeView()
        .environmentObject(UserViewModel())
}
