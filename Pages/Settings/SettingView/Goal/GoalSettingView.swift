//
//  GoalSettingView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 23.02.2024.
//

import SwiftUI

struct GoalSettingView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    // Используем словарь для хранения состояний нажатия по уникальному идентификатору текстового элемента
    @State private var isPressedDict: [Int: Bool] = [:]
    @Environment(\.dismiss) var dismiss
    @AppStorage("NotificationPermission") var isNotificationPermitted: Bool = false
    
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
                        .onTapGesture {
                            isPressedDict = isPressedDict.mapValues { _ in false }
                            self.isPressedDict[0] = true
                            userVM.user.goalText = "Find a new job 👨‍💻"
                        }
                        
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
                        .onTapGesture {
                            isPressedDict = isPressedDict.mapValues { _ in false }
                            self.isPressedDict[1] = true
                            userVM.user.goalText = "Just get a new skill😎"
                        }
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
                        .onTapGesture {
                            isPressedDict = isPressedDict.mapValues { _ in false }
                            self.isPressedDict[2] = true
                            userVM.user.goalText = "Learn for fun🙂"
                        }
                        
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
                        .onTapGesture {
                            isPressedDict = isPressedDict.mapValues { _ in false }
                            self.isPressedDict[3] = true
                            userVM.user.goalText = "Learn for school🏫"
                        }
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
                        .onTapGesture {
                            isPressedDict = isPressedDict.mapValues { _ in false }
                            self.isPressedDict[4] = true
                            userVM.user.goalText = "Get raise🔝"
                        }
                        
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
                                .multilineTextAlignment(.center)
                                .padding()
                                .font(Font.custom("Poppins", size: 16))
                                .lineSpacing(15.60)
                                .onTapGesture {
                                    for key in 0...4 {
                                        isPressedDict[key] = false
                                    }
                                }
                        }
                        .frame(width: 180, height: 52)
                    }
                }
            }
            
            VStack(spacing: 20) {
                Text("How many days a week will you study? 🗓️")
                    .font(Font.Poppins(size: 16.70).weight(.medium))
                
                GoalSliderView(dayOfWeek: $userVM.user.goalDay)
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
                            .frame(width: 162, height: 48)
                            .background(Color("Purple"))
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .inset(by: 0.50)
                                    .stroke(Color(red: 0.41, green: 0.05, blue: 0.92), lineWidth: 0.50)
                            )
                            .offset(x: 0, y: 0)
                        
                        Text("Yes, notify me ✅")
                            .font(Font.Poppins(size: 15).weight(.medium))
                            .foregroundColor(isPressedDict[5, default: false] ? .white : .black)
                            .offset(x: 2, y: 1)
                    }
                    .onTapGesture {
                        self.isPressedDict[6] = false
                        self.isPressedDict[5] = true
                        
                        if isNotificationPermitted {
                            NotificationManager.shared.sendNotification(title: "Notification", body: "You have approved the notifications!")
                        } else {
                            NotificationManager.shared.requestAuthorization { granted in
                                self.isNotificationPermitted = granted
                                NotificationManager.shared.sendNotification(title: "Notification", body: "You have approved the notifications!")
                            }
                        }
                    }
                    
                    ZStack() {
                        
                        Rectangle()
                            .foregroundColor(isPressedDict[6, default: false] ? Color("Purple") : .white)
                            .frame(width: 162, height: 48)
                            .background(.white)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .inset(by: 0.50)
                                    .stroke(Color(red: 0.41, green: 0.05, blue: 0.92), lineWidth: 0.50)
                            )
                            .offset(x: 0, y: 0)
                        
                        Text("No, thanks ❌")
                            .font(Font.Poppins(size: 15).weight(.medium))
                            .foregroundColor(isPressedDict[6, default: false] ? .white : .black)
                            .offset(x: 4, y: 0)
                    }
                    .onTapGesture {
                        self.isPressedDict[5] = false
                        self.isPressedDict[6] = true

                        if isNotificationPermitted {
                            NotificationManager.shared.sendNotification(title: "Notifications are disabled", body: "This is your last notification:(")
                            self.isNotificationPermitted = false
                        }
                    }
                }
            }
            .frame(width: 407, height: 92)
            
            HStack {
                Spacer()
                
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Save")
                        .font(Font.Poppins(size: 15.73))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 105, height: 40)
                        .background(Color("Purple"))
                        .cornerRadius(15)
                })
                .padding(.trailing, 20)
            }
        }
    }
}

#Preview {
    GoalSettingView()
        .environmentObject(UserViewModel())
}
