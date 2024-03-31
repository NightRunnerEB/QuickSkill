//
//  SignUpView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 17.02.2024.
//

import SwiftUI
import PartialSheet

struct PresentationView: View {
    @State private var isSelected = false
    @State private var isSheetPresented = false
    @State private var isShowingLogIn = false
    @State private var isShowingRegistr = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome!")
                    .font(Font.custom("Poppins", size: 22).weight(.medium))
                    .foregroundColor(.black)
                    .frame(width: 292, height: 60)
                    .background(Color(red: 0.93, green: 0.93, blue: 0.93).opacity(0.80))
                    .cornerRadius(24)
                    .padding(.top, 30)
                
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Image("Source Code")
                        Spacer()
                        Image("Marker Pen")
                            .padding(.bottom, 70)
                        Spacer()
                        Image("Literature")
                        Spacer()
                    }
                    
                    Image("Quickskill")
                    
                    HStack {
                        Spacer()
                        Image("Console")
                        Spacer()
                        Image("iMac")
                            .padding(.top, 70)
                        Spacer()
                        Image("Rocket")
                        Spacer()
                    }
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    VStack(spacing: 8) {
                        Text("Master skills fast and efficient using AI")
                            .font(Font.custom("Poppins", size: 17).weight(.medium))
                            .foregroundColor(.black)
                    }
                    .frame(height: 56)
                }
                .padding(8)
                .frame(width: 364, height: 60)
                .background(Color(red: 0.93, green: 0.93, blue: 0.93).opacity(0.80))
                .cornerRadius(24)
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    PSButton(
                        isPresenting: $isSheetPresented,
                        label: {
                            HStack(alignment: .bottom) {
                                Text("More options")
                                    .font(Font.custom("Poppins", size: 17).weight(.semibold))
                                    .foregroundColor(Color("Purple"))
                            }
                        })
                    .partialSheet(
                        isPresented: $isSheetPresented,
                        content: SocialNetworksView.init
                    )
                    
                    Spacer()
                    // Кнопка для перехода на представление входа в систему
                    NavigationLink(destination: LogInView()) {
                    }
                    
                    Button(action: {
                        isShowingLogIn = true
                    }, label: {
                        Text("Log In")
                            .font(Font.custom("Poppins", size: 17).weight(.semibold))
                            .foregroundColor(Color("Purple"))
                    })
                    .fullScreenCover(isPresented: $isShowingLogIn) {
                        LogInView()
                    }
                    
                    Spacer()
                    // Кнопка для перехода на представление регистрации
                    Button(action: {
                        isShowingRegistr = true
                    }, label: {
                        Text("Sign Up")
                            .font(Font.custom("Poppins", size: 17).weight(.semibold))
                            .foregroundColor(Color("Purple"))
                    })
                    .fullScreenCover(isPresented: $isShowingRegistr) {
                        RegistrationView(isShowingLogIn: $isShowingLogIn)
                    }
                    
                    Spacer(minLength: 56)
                }
                .padding(.top, 60)
                
                
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .attachPartialSheetToRoot()
    }
}

#Preview {
    PresentationView()
}
