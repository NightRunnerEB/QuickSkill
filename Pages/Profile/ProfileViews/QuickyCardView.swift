//
//  QuickyCardView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 29.02.2024.
//

import SwiftUI

struct QuickyCardView: View {
    let experience: Int
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Your Quicky")
                        .font(Font.custom("Poppins", size: 22).weight(.semibold))
                    
                    Text("Check your level ")
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
                    
                    Image("Quicky")
                    
                    Text("15 lvl")
                        .font(Font.custom("Poppins", size: 22).weight(.semibold))
                        .foregroundStyle(LinearGradient(colors: [.blue, .teal], startPoint: .leading, endPoint: .trailing))
                        .offset(x: 130, y: -135)
                    
                }
                
                ZStack {
                    
                    CardShape()
                        .fill(Color("Yellow_card"))
                        .frame(width: 343, height: 68)
                        .rotationEffect(.degrees(180))
                    
                    HStack {
                        ZStack(alignment: .leading) {
                            // Фоновый прямоугольник
                            Rectangle()
                                .foregroundStyle(.clear)
                                .frame(width: 224, height: 39.69)
                                .background(.white)
                                .cornerRadius(28.35)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 28.35)
                                        .inset(by: 0.57)
                                        .stroke(Color(red: 0.41, green: 0.05, blue: 0.92), lineWidth: 0.57)
                                )
                            
                            // Прямоугольник для индикатора заполнения
                            Rectangle()
                                .foregroundStyle(.clear)
                                .frame(width: 102 + CGFloat(experience % 1000) / 8.18, height: 39.69)
                                .background(Color("Purple"))
                                .animation(.linear, value: CGFloat(experience))
                                .cornerRadius(28.35)
                            
                            // Текст поверх всего
                            Text("\(experience) XP")
                                .font(Font.Poppins(size: 20).weight(.semibold))
                                .foregroundColor(.white)
                                .padding(.leading, 10)
                        }
                        
                        Text("\((experience / 1000 + 1) * 1000) XP")
                            .font(Font.custom("Poppins", size: 17).weight(.semibold))
                            .foregroundStyle(Color("Purple"))
                        
                    }
                }
            }
        }
    }
    
}
