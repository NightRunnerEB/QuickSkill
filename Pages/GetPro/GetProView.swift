//
//  GetProView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 25.02.2024.
//

import SwiftUI

struct GetProView: View {
    @State private var animateGradient = false
    @State private var isOn = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 17.44, height: 17.44)
                        .foregroundStyle(.black)
                })
            }
            .padding(.trailing, 27)
            .padding(.bottom, 10)
            
            Text("Choose your plan \nto improve your experience in QuickSkill")
              .font(Font.custom("Poppins", size: 17).weight(.semibold))
              .foregroundColor(.white)
              .multilineTextAlignment(.center)
            
            TabView {
                CardViewFirst()
                CardViewSecond()
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .frame(height: 415)
            
            HStack {
                Text("Annual paying")
                    .font(Font.Poppins(size: 12))
                    .foregroundColor(.white)
                
                Toggle("", isOn: $isOn)
                    .labelsHidden()
                    .toggleStyle(ColoredToggleStyle())
            }
            .frame(width: 155, height: 29)
            .offset(x: -75)
            
            VStack {
                
                if(isOn) {
                    HStack(spacing: 16) {
                        Text("Annually:")
                            .font(Font.Poppins(size: 14).weight(.medium))
                            .lineSpacing(21.60)
                        
                        HStack(spacing: 10) {
                            Text("SAVED 36$")
                                .font(Font.Poppins(size: 12).weight(.medium))
                                .lineSpacing(21.60)
                                .foregroundColor(.white)
                        }
                        .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
                        .background(Color("Purple"))
                        .cornerRadius(15)
                        
                        Spacer()
                    }
                    
                    HStack(alignment: .bottom, spacing: 20) {
                        HStack(spacing: -7) {
                            Text("19.99$")
                                .font(Font.Poppins(size: 21.60).weight(.light))
                                .strikethrough()
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 29.02, height: 0.1)
                                .overlay(Rectangle()
                                    .stroke(.black, lineWidth: 0.36))
                                .rotationEffect(.degrees(-64.42))
                            
                            Text("mo")
                                .font(Font.Poppins(size: 12.24).weight(.medium))
                                .padding(.top, 9)
                        }
                        
                        HStack(spacing: -7) {
                            Text("16.99$")
                                .font(Font.Poppins(size: 30).weight(.medium))
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 26.31, height: 0.1)
                                .overlay(Rectangle()
                                    .stroke(.black, lineWidth: 0.50))
                                .rotationEffect(.degrees(-64.42))
                            
                            Text("mo")
                                .font(Font.Poppins(size: 17).weight(.medium))
                                .padding(.top, 9)
                            
                        }
                    }
                    
                } else {
                    HStack(spacing: 16) {
                        Text("Monthly:")
                            .font(Font.Poppins(size: 14).weight(.medium))
                            .lineSpacing(21.60)
                        
                        HStack(spacing: 10) {
                            Text("SAVED 36$")
                                .font(Font.Poppins(size: 12).weight(.medium))
                                .lineSpacing(21.60)
                                .foregroundColor(.white)
                        }
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                        .background(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.60))
                        .cornerRadius(15)
                        
                        Spacer()
                    }
                    
                    HStack(spacing: -7) {
                        Text("19.99$")
                            .font(Font.Poppins(size: 30).weight(.medium))
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 26.31, height: 0.1)
                            .overlay(Rectangle()
                                .stroke(.black, lineWidth: 0.50))
                            .rotationEffect(.degrees(-64.42))
                        
                        Text("mo")
                            .font(Font.Poppins(size: 17).weight(.medium))
                            .padding(.top, 9)
                        
                    }
                }
                
                ZStack() {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 174, height: 45)
                        .background(Color(red: 1, green: 0.84, blue: 0))
                        .cornerRadius(15)
                    
                    Text("Start 7-day trial")
                        .font(Font.Poppins(size: 17).weight(.medium))
                }
                .padding(.bottom, 8)
                
                Text("By selecting Start 7-day free trial, you agree to the QuickSkill Terms of Service")
                    .font(Font.Poppins(size: 8).weight(.light))
                
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 17, trailing: 16))
            .frame(width: 320, height: 200)
            .background(.white)
            .cornerRadius(15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color("Gradient_1").opacity(0.3), Color("Purple")]),
                                   startPoint: .bottomLeading,
                                   endPoint: .center))
        //        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        //        .hueRotation(.degrees(animateGradient ? -2 : 6))
        //        .onAppear {
        //            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
        //                animateGradient.toggle()
        //            }
        //        }
    }
}

struct ColoredToggleStyle: ToggleStyle {
    var onColor = Color(UIColor.systemGreen)
    var offColor = Color(UIColor.systemGray)
    var thumbColor = Color.white
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    configuration.isOn.toggle()
                }
            }) {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 50, height: 29)
                    .overlay(
                        Circle()
                            .fill(thumbColor)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(1.5)
                            .offset(x: configuration.isOn ? 10 : -10)
                    )
            }
        }
        .font(.title)
    }
}

#Preview {
    GetProView()
}
