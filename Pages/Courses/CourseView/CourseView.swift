//
//  CourseView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 28.02.2024.
//

import SwiftUI
import PartialSheet

struct CourseView: View {
    var course: Course?
    @EnvironmentObject var userVM: UserViewModel
    @State private var isSearchViewVisible = false
    @StateObject var topicVM = TopicViewModel()
    @State private var isExpandedDict: [Int: Bool] = [:]
    @State private var isPresentedGetPro = false
    @State private var isSheetStreakPresented = false
    @State private var isSheetCrystalPresented = false
    @State private var isSheetBatteryPresented = false
    
    private func binding(for id: Int) -> Binding<Bool> {
        Binding(
            get: { self.isExpandedDict[id, default: false] },
            set: { self.isExpandedDict[id] = $0 }
        )
    }
    
    var body: some View {
        if let course {
            if course.joined {
                NavigationView {
                    ZStack {
                        VStack {
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
                                        isPresenting: $isSheetCrystalPresented,
                                        label: {
                                            HStack(alignment: .bottom) {
                                                Image("Crystall")
                                                Text("\(userVM.user.crystall)")
                                                    .id(userVM.user.crystall)
                                                    .foregroundStyle(Color("Purple"))
                                            }
                                        })
                                    .partialSheet(
                                        isPresented: $isSheetCrystalPresented,
                                        content: SheetCrystal.init
                                    )
                                    
                                    Spacer()
                                    
                                    PSButton(
                                        isPresenting: $isSheetBatteryPresented,
                                        label: {
                                            HStack(alignment: .bottom) {
                                                Text("❤️")
                                                    .font(.system(size: 28))
                                                Text("\(userVM.user.hearts)")
                                                    .id(userVM.user.hearts)
                                                    .foregroundStyle(Color.red)
                                            }
                                        })
                                    .partialSheet(
                                        isPresented: $isSheetBatteryPresented,
                                        content: SheetBattery.init
                                    )
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0.35)) {
                                            isSearchViewVisible = true
                                        }
                                    }, label: {
                                        Image(course.media)
                                            .resizable()
                                            .frame(width: 33, height: 33)
                                    })
                                    
                                }
                                .font(Font.Poppins(size: 22).weight(.semibold))
                                .padding()
                            }
                            
                            ScrollView {
                                
                                ProgressCircleView(progress: course.progress)
                                    .frame(width: 100, height: 120)
                                
                                ForEach($topicVM.topics) { $topic in
                                    
                                    DisclosureGroup(
                                        isExpanded: binding(for: topic.id),
                                        content: {
                                            VStack(alignment: .leading, spacing: 30) {
                                                
                                                ForEach($topic.content, id: \.id) { $lesson in
                                                    HStack(alignment: .center, spacing: 8) {
                                                        Image(lesson.blocked ? "Delete Lock": "Approved Unlock")
                                                        
                                                        VStack(alignment: .leading) {
                                                            Text(lesson.name)
                                                                .font(Font.Poppins(size: 17).weight(.semibold))
                                                            
                                                            Text(lesson.description)
                                                                .font(Font.Poppins(size: 17)).opacity(0.35)
                                                        }
                                                        
                                                        Spacer()
                                                        
                                                        NavigationLink(destination: lesson.type == LessonType.lecture ? AnyView(LectureView(lesson: $lesson, topic: $topic, course: course)) : AnyView(PracticeView(course: course, topic: $topicVM.topics[topic.id + 1])), label: {
                                                            HStack(spacing: 10) {
                                                                Text("Start")
                                                                    .font(Font.custom("Poppins", size: 17))
                                                                    .foregroundColor(Color("Purple"))
                                                            }
                                                            .padding(EdgeInsets(top: 5, leading: 13, bottom: 5, trailing: 13))
                                                            .background(Color(red: 0.41, green: 0.05, blue: 0.92).opacity(0.15))
                                                            .cornerRadius(24)
                                                            .shadow(
                                                                color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 4, y: 4
                                                            )
                                                        })
                                                        .disabled(lesson.blocked)
                                                    }
                                                
                                                }
                                            }
                                            .padding()
                                        },
                                        label: {
                                            ZStack {
                                                Rectangle()
                                                    .frame(width: 364, height: 50)
                                                    .foregroundColor(.clear)
                                                    .background(Color("Block"))
                                                    .cornerRadius(20)
                                                
                                                HStack {
                                                    if topic.blocked {
                                                        Image(systemName: "xmark.circle.fill")
                                                            .font(.system(size: 24)) // You can adjust the size as needed
                                                            .foregroundColor(.black) // You can adjust the color as needed : Image("Ok_2")
                                                            .padding(.leading, 8)
                                                    } else {
                                                        Image("Ok_2")
                                                            .padding(.leading, 8)
                                                    }
                                                    
                                                    Text("\(topic.name)")
                                                        .font(Font.Poppins(size: 15.74).weight(.bold))
                                                    
                                                    Spacer()
                                                }
                                            }
                                        }
                                    )
                                    .disabled(topic.blocked)
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
                        }
                        .attachPartialSheetToRoot()
                        
                        // Выплывающая детальная информация
                        if isSearchViewVisible {
                            GeometryReader { geometry in
                                HStack {
                                    Spacer()
                                    
                                    DetailView(isSearchViewVisible: $isSearchViewVisible)
                                        .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.4)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                        .shadow(radius: 5)
                                        .padding(.top, 60)
                                }
                            }
                            .background(
                                Color.black.opacity(0.3)
                                    .edgesIgnoringSafeArea(.all)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.35)) {
                                            isSearchViewVisible = false
                                        }
                                    }
                            )
                        }
                    }
                    .onAppear {
                        if topicVM.topics.isEmpty {
                            topicVM.getTopics(courseId: course.id)
                        }
                    }
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
                                    isPresenting: $isSheetCrystalPresented,
                                    label: {
                                        HStack(alignment: .bottom) {
                                            Image("Crystal")
                                            Text("\(userVM.user.crystall)")
                                                .foregroundStyle(Color("Purple"))
                                        }
                                    })
                                .partialSheet(
                                    isPresented: $isSheetCrystalPresented,
                                    content: SheetCrystal.init
                                )
                                
                                Spacer()
                                
                                PSButton(
                                    isPresenting: $isSheetBatteryPresented,
                                    label: {
                                        HStack(alignment: .bottom) {
                                            Image("Battery")
                                            Text("\(userVM.user.hearts)")
                                                .foregroundStyle(Color("Success-scale"))
                                        }
                                    })
                                .partialSheet(
                                    isPresented: $isSheetBatteryPresented,
                                    content: SheetBattery.init
                                )
                                
                                Spacer()
                                
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.35)) {
                                        isSearchViewVisible = true
                                    }
                                }, label: {
                                    Image(course.media)
                                        .resizable()
                                        .frame(width: 33, height: 33)
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
                                    .font(Font.custom("Inter", size: 20).weight(.medium))
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
        } else {
            Text("Start the course soon!/n A successful future awaits you")
        }
    }
}

//#Preview {
//    CourseView(courseId: 0)
//        .environmentObject(UserViewModel())
//}
