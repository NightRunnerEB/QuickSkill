//
//  ContactUsView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 23.02.2024.
//

import SwiftUI

struct ContactUsView: View {
    @State private var isExpanded1 = false
    @State private var isExpanded2 = false
    @State private var isExpanded3 = false
    @State private var topic = ""
    @State private var email = ""
    @State private var question = ""
    
    var body: some View {
        VStack {
            ScrollView {
                
                VStack(spacing: 12) {
                    HStack(spacing: 16) {
                        Image("Help")
                        
                        Text("Frequent questions")
                            .font(Font.Poppins(size: 22).weight(.medium))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 8) {
                        
                        DisclosureGroup("1. How can I cancel subscription?", isExpanded: $isExpanded1) {
                            Text("There’re several ways to do it. Firstly, forget about your money and close this app. Secondly, you can tell your friends about our courses. So we’ll take their money too.")
                                .lineSpacing(7)
                                .padding()
                                .frame(width: 360, height: 135)
                                .background(Color("Block"))
                                .cornerRadius(15)
                        }
                        
                        DisclosureGroup("2. How can I delete my account?", isExpanded: $isExpanded2) {
                            Text("To delete your account, you should go to the settings menu and select the appropriate item.")
                                .lineSpacing(7)
                                .padding()
                                .frame(width: 360, height: 110)
                                .background(Color("Block"))
                                .cornerRadius(15)
                        }
                        
                        DisclosureGroup("3. How can I change my plan?", isExpanded: $isExpanded3) {
                            Text("To change the plan, you need to pay a year in advance, as compensation for moral damages to us.")
                                .lineSpacing(7)
                                .padding()
                                .frame(width: 360, height: 110)
                                .background(Color("Block"))
                                .cornerRadius(15)
                        }
                    }
                    .font(Font.Poppins(size: 17))
                    .accentColor(.black)
                }
                .padding(.leading, 10)
                .padding(.trailing, 15)
                
                HStack(spacing: 16) {
                    Image("Mail")
                    
                    Text("Still have any questions?\nContact us!")
                        .font(Font.Poppins(size: 20).weight(.medium))
                }
                .padding(.top, 27)
                .padding(.bottom, 6)
                
                VStack(spacing: 26) {
                    VStack(alignment: .leading) {
                        Text("Topic")
                            .font(Font.Poppins(size: 22))
                            .lineSpacing(23.48)
                        
                        TextField("Enter topic", text: $topic)
                            .padding(EdgeInsets(top: 0, leading: 18.15, bottom: 0, trailing: 0))
                            .frame(width: 325, height: 49.10)
                            .background(.white)
                            .cornerRadius(16)
                            .shadow(
                                color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4.41, y: 4.41
                            )
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Email for contact")
                            .font(Font.Poppins(size: 22))
                            .lineSpacing(23.48)
                        
                        TextField("Enter your email", text: $email)
                            .padding(EdgeInsets(top: 0, leading: 18.15, bottom: 0, trailing: 0))
                            .frame(width: 325, height: 49.10)
                            .background(.white)
                            .cornerRadius(16)
                            .shadow(
                                color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4.41, y: 4.41
                            )
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Question")
                            .font(Font.Poppins(size: 22))
                            .lineSpacing(23.48)
                        
                        TextField("Describe your problem", text: $question)
                            .padding(EdgeInsets(top: 0, leading: 18.15, bottom: 0, trailing: 0))
                            .frame(width: 325, height: 320)
                            .background(.white)
                            .cornerRadius(16)
                            .shadow(
                                color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4.41, y: 4.41
                            )
                    }
                    
                    Button(action: {
                        //
                    }, label: {
                        
                        ZStack() {
                            
                          Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 135, height: 52.88)
                            .background(Color("Purple"))
                            .cornerRadius(16.52)
                            
                          Text("Send")
                            .font(Font.Poppins(size: 18.73))
                            .lineSpacing(23.48)
                            .foregroundColor(.white)
                        }
                    })
                }
                .padding()
                .frame(width: 360, height: 715.40)
                .background(Color("Block"))
                .cornerRadius(15)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.4), radius: 5, y: 3)
            }
        }
    }
}

#Preview {
    ContactUsView()
}
