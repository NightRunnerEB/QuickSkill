//
//  GoalSliderView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 23.02.2024.
//

import SwiftUI

struct GoalSliderView: View {
    // Состояние для хранения текущего значения слайдера
    @Binding var dayOfWeek: Double
    // Массив меток для дней недели
    private let days = [1, 2, 3, 4, 5, 6, 7]
    
    var body: some View {
        VStack {
            Slider(value: $dayOfWeek, in: 1...7, step: 1)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.bottom, 2)
            
            HStack(spacing: 43) {
                ForEach(days, id: \.self) { day in
                    VStack {
                        Rectangle()
                            .foregroundColor(day == Int(dayOfWeek) ? .white : .black)
                            .frame(width: 12, height: 0.8)
                            .overlay(Rectangle()
                                .stroke(day == Int(dayOfWeek) ? .white : .black, lineWidth: 0.50))
                            .rotationEffect(.degrees(-90))
                            .padding(.bottom, 4)
                        
                        Text("\(day)")
                            .font(.system(size: day == Int(dayOfWeek) ? 24 : 16))
                            .foregroundColor(day == Int(dayOfWeek) ? Color("Purple") : .black)
                            .scaleEffect(day == Int(dayOfWeek) ? 1.5 : 1)
                            .animation(.easeIn, value: dayOfWeek)
                    }
                }
            }
        }
    }
}
