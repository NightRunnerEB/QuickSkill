//
//  CalendarCardView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 29.02.2024.
//

import SwiftUI

struct CalendarCardView: View {
    
    let streak: Int
    let streakRecord: Int
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Your Activity")
                        .font(Font.custom("Poppins", size: 22).weight(.semibold))
                    
                    Text("Streak calendar")
                        .font(Font.custom("Poppins", size: 22).weight(.medium))
                        .foregroundColor(Color(red: 0.72, green: 0.72, blue: 0.78))
                }
                
                Spacer()
            }
            .padding(.leading, 30)
            
            VStack(spacing: 0) {
                
                ZStack {
                    CardShape()
                        .fill(Color.gray.opacity(0.05))
                        .frame(width: 343, height: 324)
                    
                    Image("Calendar")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 343, height: 324)
                }
                
                ZStack {
                    CardShape()
                        .fill(Color("Purple"))
                        .frame(width: 343, height: 68)
                        .rotationEffect(.degrees(180))
                    
                    HStack {
                        
                        VStack {
                            Text("Current")
                                .font(Font.Poppins(size: 22))
                                .foregroundColor(.white)
                            
                            HStack {
                                Text("\(streak)")
                                    .foregroundStyle(LinearGradient(colors: [.orange, .red], startPoint: .bottom, endPoint: .top))
                                
                                Text("days")
                                    .font(Font.custom("Poppins", size: 17))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("Record")
                                .font(Font.Poppins(size: 22))
                                .foregroundColor(.white)
                            
                            HStack {
                                Text("\(streakRecord)")
                                    .foregroundStyle(LinearGradient(colors: [.orange, .red], startPoint: .bottom, endPoint: .top))
                                
                                Text("days")
                                    .font(Font.custom("Poppins", size: 17))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .frame(width: 223, height: 70)
        
                }
                
            }
        }
    }
}
