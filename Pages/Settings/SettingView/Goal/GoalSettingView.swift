//
//  GoalSettingView.swift
//  QuickSkill
//
//  Created by Али Сейфельдин on 23.02.2024.
//

import SwiftUI

struct GoalSettingView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    // Используем словарь для хранения состояний нажатия по уникальному идентификатору текстового элемента
    @State private var isPressedDict: [Int: Bool] = [:]
    @Environment(\.dismiss) var dismiss

    
    var body: some View {
        VStack(spacing: 40) {
            
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
            
            HStack {
                Image("Goal_settings")
                    .resizable()
                    .frame(width: 29.70, height: 28.60)

                Text("Goal settings")
                    .font(Font.Poppins(size: 22).weight(.medium))
                
                Spacer()
            }
            .padding(.leading, 24)
            
            VStack(spacing: 24) {
                
                Text("What is your goal? 🎯")
                    .font(Font.Poppins(size: 19).weight(.medium))
                    .lineSpacing(15.60)
                
                VStack(alignment: .leading, spacing: 32) {
                    
                    HStack(alignment: .top, spacing: 16) {
                        
                        ZStack() {
                            
                            Rectangle()
                                .foregroundColor(isPressedDict[0, default: false] ? Color("Purple") : .white)
                                .frame(width: 180, height: 52)
                                .background(.white)
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .inset(by: 0.50)
                                        .stroke(.black, lineWidth: 0.50)
                                )
                            
                            Text("Find a new job 👨‍💻")
                                .font(Font.Poppins(size: 16))
                                .lineSpacing(15.60)
                                .foregroundColor(isPressedDict[0, default: false] ? .white : .black)
                        }
                        .onLongPressGesture(minimumDuration: 10, pressing: { isPressing in
                                self.isPressedDict[0] = isPressing
                        }, perform: {
                            userVM.user.goalText = "Find a new job 👨‍💻"
                        })
                        
                        ZStack() {
                            
                            Rectangle()
                                .foregroundColor(isPressedDict[1, default: false] ? Color("Purple") : .white)
                                .frame(width: 180, height: 52)
                                .background(Color(red: 0.41, green: 0.05, blue: 0.92))
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .inset(by: 0.50)
                                        .stroke(.black, lineWidth: 0.50)
                                )
                            
                            Text("Just get a new skill😎")
                                .font(Font.Poppins(size: 16))
                                .lineSpacing(15.60)
                                .foregroundColor(isPressedDict[1, default: false] ? .white : .black)

                        }
                        .onLongPressGesture(minimumDuration: 10, pressing: { isPressing in
                                self.isPressedDict[1] = isPressing
                        }, perform: {
                            userVM.user.goalText = "Just get a new skill😎"
                        })
                    }
                    
                    HStack(alignment: .top, spacing: 16) {
                        ZStack() {
                            
                            Rectangle()
                                .foregroundColor(isPressedDict[2, default: false] ? Color("Purple") : .white)
                                .frame(width: 180, height: 52)
                                .background(.white)
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .inset(by: 0.50)
                                        .stroke(.black, lineWidth: 0.50)
                                )

                            Text("Learn for fun🙂")
                                .font(Font.Poppins(size: 16))
                                .lineSpacing(15.60)
                                .foregroundColor(isPressedDict[2, default: false] ? .white : .black)
                        }
                        .onLongPressGesture(minimumDuration: 10, pressing: { isPressing in
                                self.isPressedDict[2] = isPressing
                        }, perform: {
                            userVM.user.goalText = "Learn for fun🙂"
                        })
                        
                        ZStack() {
                            Rectangle()
                                .foregroundColor(isPressedDict[3, default: false] ? Color("Purple") : .white)
                                .frame(width: 180, height: 52)
                                .background(.white)
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .inset(by: 0.50)
                                        .stroke(.black, lineWidth: 0.50)
                                )
                                .offset(x: 0, y: 0)
                            Text("Learn for school🏫")
                                .font(Font.Poppins(size: 16))
                                .lineSpacing(15.60)
                                .foregroundColor(isPressedDict[3, default: false] ? .white : .black)
                        }
                        .onLongPressGesture(minimumDuration: 10, pressing: { isPressing in
                                self.isPressedDict[3] = isPressing
                        }, perform: {
                            userVM.user.goalText = "Learn for school🏫"
                        })
                    }
                    
                    HStack(alignment: .top, spacing: 16) {
                        ZStack() {
                            Rectangle()
                                .foregroundColor(isPressedDict[4, default: false] ? Color("Purple") : .white)
                                .frame(width: 180, height: 52)
                                .background(.white)
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .inset(by: 0.50)
                                        .stroke(.black, lineWidth: 0.50)
                                )

                            Text("Get raise🔝")
                                .font(Font.Poppins(size: 16))
                                .lineSpacing(15.60)
                                .foregroundColor(isPressedDict[4, default: false] ? .white : .black)
                        }
                        .onLongPressGesture(minimumDuration: 10, pressing: { isPressing in
                                self.isPressedDict[4] = isPressing
                        }, perform: {
                            userVM.user.goalText = "Get raise🔝"
                        })
                        
                        ZStack() {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 180, height: 52)
                                .background(.white)
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .inset(by: 0.50)
                                        .stroke(.black, lineWidth: 0.50)
                                )
                            
                            TextField("Or type your own...", text: $userVM.user.goalText)
                                .padding()
                                .font(Font.custom("Poppins", size: 16))
                                .lineSpacing(15.60)
                        }
                        .frame(width: 180, height: 52)
                    }
                }
            }
            
            VStack(spacing: 20) {
                Text("How many days a week will you study? 🗓️")
                    .font(Font.Poppins(size: 16.70).weight(.medium))
                
//                GoalSliderView(dayOfWeek: $userVM.user.goalDay)
            }
            
            VStack(spacing: 32) {
                
              Text("Would you like to get reminders on your email?📨")
                .font(Font.Poppins(size: 14.50).weight(.medium))
                .lineSpacing(8)
                .foregroundColor(.black)
                
              HStack(alignment: .top, spacing: 24) {
                  
                ZStack() {
                    
                  Rectangle()
                        .foregroundColor(isPressedDict[5, default: false] ? Color("Purple") : .white)
                    .frame(width: 162, height: 52)
                    .background(Color("Purple"))
                    .cornerRadius(15)
                    .overlay(
                      RoundedRectangle(cornerRadius: 15)
                        .inset(by: 0.50)
                        .stroke(Color(red: 0.41, green: 0.05, blue: 0.92), lineWidth: 0.50)
                    )
                    .offset(x: 0, y: 0)
                    
                  Text("Yes, notify me ✅")
                    .font(Font.Poppins(size: 16.50).weight(.medium))
                    .lineSpacing(8)
                    .foregroundColor(isPressedDict[5, default: false] ? .white : .black)
                    .offset(x: 2, y: 1)
                }
                .onLongPressGesture(minimumDuration: 10, pressing: { isPressing in
                        self.isPressedDict[5] = isPressing
                }, perform: {
                    // Действие, которое выполняется после завершения жеста, если необходимо
                })
                  
                ZStack() {
                    
                  Rectangle()
                        .foregroundColor(isPressedDict[6, default: false] ? Color("Purple") : .white)
                    .frame(width: 162, height: 52)
                    .background(.white)
                    .cornerRadius(15)
                    .overlay(
                      RoundedRectangle(cornerRadius: 15)
                        .inset(by: 0.50)
                        .stroke(Color(red: 0.41, green: 0.05, blue: 0.92), lineWidth: 0.50)
                    )
                    .offset(x: 0, y: 0)
                    
                  Text("No, thanks ❌")
                    .font(Font.Poppins(size: 16.50).weight(.medium))
                    .lineSpacing(8)
                    .foregroundColor(isPressedDict[6, default: false] ? .white : .black)
                    .offset(x: 4, y: 0)
                }
                .onLongPressGesture(minimumDuration: 10, pressing: { isPressing in
                        self.isPressedDict[6] = isPressing
                }, perform: {
                    // Действие, которое выполняется после завершения жеста, если необходимо
                })
              }
            }
            .frame(width: 407, height: 92)
        }
    }
}

//#Preview {
//    GoalSettingView()
//        .environmentObject(UserViewModel())
//}
