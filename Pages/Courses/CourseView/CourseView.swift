//
//  CourseView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 28.02.2024.
//

import SwiftUI
import PartialSheet

struct CourseView: View {
    
    @Binding var course: Course
    
    @EnvironmentObject var userVM: UserViewModel
    @StateObject var topicVM = TopicViewModel()
    @State private var isExpandedDict: [Int: Bool] = [:]
    @State private var isPresentedAllCourses = false
    @State private var isPresentedGetPro = false
    @State private var isSheetStreakPresented = false
    @State private var isSheetCrystallPresented = false
    @State private var isSheetBatteryPresented = false
    
    private func binding(for id: Int) -> Binding<Bool> {
        Binding(
            get: { self.isExpandedDict[id, default: false] },
            set: { self.isExpandedDict[id] = $0 }
        )
    }
    
    var body: some View {
        if course.joined {
            NavigationView {
                ScrollView {
                    VStack {
                        HStack {
                            PSButton(
                                isPresenting: $isSheetStreakPresented,
                                label: {
                                    HStack(alignment: .bottom) {
                                        Image("streak_ball")
                                        Text("\(userVM.user.streak)")
                                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .top, endPoint: .bottom))
                                    }
                                })
                            .partialSheet(
                                isPresented: $isSheetStreakPresented,
                                content: SheetStreak.init
                            )
                            
                            Spacer()
                            
                            PSButton(
                                isPresenting: $isSheetCrystallPresented,
                                label: {
                                    HStack(alignment: .bottom) {
                                        Image("Crystall")
                                        Text("\(userVM.user.crystalls)")
                                            .foregroundStyle(Color("Purple"))
                                    }
                                })
                            .partialSheet(
                                isPresented: $isSheetCrystallPresented,
                                content: SheetCrystall.init
                            )
                            
                            Spacer()
                            
                            PSButton(
                                isPresenting: $isSheetBatteryPresented,
                                label: {
                                    HStack(alignment: .bottom) {
                                        Image("Battery")
                                        Text("\(userVM.user.energy)")
                                            .foregroundStyle(Color("Success-scale"))
                                    }
                                })
                            .partialSheet(
                                isPresented: $isSheetBatteryPresented,
                                content: SheetBattery.init
                            )
                            
                            Spacer()
                            
                            Button(action: {
                                isPresentedAllCourses = true
                            }, label: {
                                Image(course.media)
                                    .resizable()
                                    .frame(width: 33, height: 33)
                            })
                            .fullScreenCover(isPresented: $isPresentedAllCourses, content: {
                                AllCoursesView()
                            })
                            
                        }
                        .font(Font.Poppins(size: 22).weight(.semibold))
                        .padding()
                        
                        ProgressCircleView(progress: course.progress)
                            .frame(width: 100, height: 120)
                    }
                    
                    ForEach(topicVM.topics) { topic in
                        Section {
                            DisclosureGroup(
                                isExpanded: binding(for: topic.id),
                                content: {
                                    VStack(alignment: .leading, spacing: 30) {
//                                        HStack(alignment: .center, spacing: 8) {
//                                            Image("Approved Unlock")
//                                            
//                                            VStack(alignment: .leading) {
//                                                Text(lesson.lecture.title)
//                                                    .font(Font.Poppins(size: 17).weight(.semibold))
//                                                
//                                                Text(lesson.lecture.description)
//                                                    .font(Font.Poppins(size: 17)).opacity(0.35)
//                                            }
//                                            
//                                            Spacer()
//                                        }
//                                        
//                                        HStack(alignment: .center, spacing: 8) {
//                                            Image("Approved Unlock")
//                                            
//                                            VStack(alignment: .leading) {
//                                                Text(lesson.practice.title)
//                                                    .font(Font.Poppins(size: 17).weight(.semibold))
//                                                
//                                                Text(lesson.practice.description)
//                                                    .font(Font.Poppins(size: 17)).opacity(0.35)
//                                            }
//                                            Spacer()
//                                        }
                                    }
                                    .frame(width: 380, height: 120)
                                },
                                label: {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 364, height: 50)
                                            .foregroundColor(.clear)
                                            .background(Color("Block"))
                                            .cornerRadius(24)
                                        
                                        HStack {
                                            Image("Ok_2")
                                                .padding(.leading, 8)
                                            
                                            Text("\(topic.name)")
                                                .font(Font.Poppins(size: 15.74).weight(.bold))
                                            
                                            Spacer()
                                        }
                                    }
                                }
                            )
                        }
                        .padding(
                            EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 8)
                        )
                        .accentColor(.black)
                    }
                    
                    VStack(spacing: 8.40) {
                        VStack(spacing: 0) {
                            Image("Diploma")
                            Text("Certificate")
                                .font(Font.custom("Inter", size: 22).weight(.medium))
                        }
                        Text("Discover your perfect course with QuickSkill's personalized recommendation quiz – unlock your learning journey today! ")
                            .font(Font.custom("Inter", size: 15))
                            .lineSpacing(8)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.60))
                    }
                    .frame(width: 358, height: 199.61)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            isPresentedGetPro = true
                        }, label: {
                            Text("Subscribe")
                                .font(Font.Poppins(size: 20.66).weight(.medium))
                                .padding(
                                    EdgeInsets(top: 13.66, leading: 21.01, bottom: 13.66, trailing: 21.01)
                                )
                                .foregroundColor(.white)
                                .background(Color(red: 1, green: 0.84, blue: 0))
                                .cornerRadius(10.51)
                                .listRowSeparator(.hidden)
                        })
                        .fullScreenCover(isPresented: $isPresentedGetPro, content: {
                            GetProView()
                        })
                        
                        Spacer()
                    }
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .attachPartialSheetToRoot()
            }
        } else {
            NavigationView {
                ScrollView {
                    VStack {
                        HStack {
                            PSButton(
                                isPresenting: $isSheetStreakPresented,
                                label: {
                                    HStack(alignment: .bottom) {
                                        Image("streak_ball")
                                        Text("\(userVM.user.streak)")
                                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .top, endPoint: .bottom))
                                    }
                                })
                            .partialSheet(
                                isPresented: $isSheetStreakPresented,
                                content: SheetStreak.init
                            )
                            
                            Spacer()
                            
                            PSButton(
                                isPresenting: $isSheetCrystallPresented,
                                label: {
                                    HStack(alignment: .bottom) {
                                        Image("Crystall")
                                        Text("\(userVM.user.crystalls)")
                                            .foregroundStyle(Color("Purple"))
                                    }
                                })
                            .partialSheet(
                                isPresented: $isSheetCrystallPresented,
                                content: SheetCrystall.init
                            )
                            
                            Spacer()
                            
                            PSButton(
                                isPresenting: $isSheetBatteryPresented,
                                label: {
                                    HStack(alignment: .bottom) {
                                        Image("Battery")
                                        Text("\(userVM.user.energy)")
                                            .foregroundStyle(Color("Success-scale"))
                                    }
                                })
                            .partialSheet(
                                isPresented: $isSheetBatteryPresented,
                                content: SheetBattery.init
                            )
                            
                            Spacer()
                            
                            Button(action: {
                                isPresentedAllCourses = true
                            }, label: {
                                Image(course.media)
                                    .resizable()
                                    .frame(width: 33, height: 33)
                            })
                            .fullScreenCover(isPresented: $isPresentedAllCourses, content: {
                                AllCoursesView()
                            })
                            
                        }
                        .font(Font.Poppins(size: 22).weight(.semibold))
                        .padding()
                        
                        ProgressCircleView(progress: course.progress)
                            .frame(width: 100, height: 120)
                    }
                    
                    ForEach(topicVM.topics) { topic in
                        Section {
                            DisclosureGroup(
                                isExpanded: binding(for: topic.id),
                                content: {
                                    VStack(alignment: .leading, spacing: 30) {
//                                        HStack(alignment: .center, spacing: 8) {
//                                            Image("Approved Unlock")
//
//                                            VStack(alignment: .leading) {
//                                                Text(lesson.lecture.title)
//                                                    .font(Font.Poppins(size: 17).weight(.semibold))
//
//                                                Text(lesson.lecture.description)
//                                                    .font(Font.Poppins(size: 17)).opacity(0.35)
//                                            }
//
//                                            Spacer()
//                                        }
//
//                                        HStack(alignment: .center, spacing: 8) {
//                                            Image("Approved Unlock")
//
//                                            VStack(alignment: .leading) {
//                                                Text(lesson.practice.title)
//                                                    .font(Font.Poppins(size: 17).weight(.semibold))
//
//                                                Text(lesson.practice.description)
//                                                    .font(Font.Poppins(size: 17)).opacity(0.35)
//                                            }
//                                            Spacer()
//                                        }
                                    }
                                    .frame(width: 380, height: 120)
                                },
                                label: {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 364, height: 50)
                                            .foregroundColor(.clear)
                                            .background(Color("Block"))
                                            .cornerRadius(24)
                                        
                                        HStack {
                                            Image("Ok_2")
                                                .padding(.leading, 8)
                                            
                                            Text("\(topic.name)")
                                                .font(Font.Poppins(size: 15.74).weight(.bold))
                                            
                                            Spacer()
                                        }
                                    }
                                }
                            )
                        }
                        .padding(
                            EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 8)
                        )
                        .accentColor(.black)
                    }
                    
                    VStack(spacing: 8.40) {
                        VStack(spacing: 0) {
                            Image("Diploma")
                            Text("Certificate")
                                .font(Font.custom("Inter", size: 22).weight(.medium))
                        }
                        Text("Discover your perfect course with QuickSkill's personalized recommendation quiz – unlock your learning journey today! ")
                            .font(Font.custom("Inter", size: 15))
                            .lineSpacing(8)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.60))
                    }
                    .frame(width: 358, height: 199.61)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            isPresentedGetPro = true
                        }, label: {
                            Text("Subscribe")
                                .font(Font.Poppins(size: 20.66).weight(.medium))
                                .padding(
                                    EdgeInsets(top: 13.66, leading: 21.01, bottom: 13.66, trailing: 21.01)
                                )
                                .foregroundColor(.white)
                                .background(Color(red: 1, green: 0.84, blue: 0))
                                .cornerRadius(10.51)
                                .listRowSeparator(.hidden)
                        })
                        .fullScreenCover(isPresented: $isPresentedGetPro, content: {
                            GetProView()
                        })
                        
                        Spacer()
                    }
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .attachPartialSheetToRoot()
            }
        }
    }
}

//#Preview {
//    CourseView(course: Course.allCourses[0])
//        .environmentObject(UserViewModel())
//}
