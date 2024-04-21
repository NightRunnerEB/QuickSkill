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
        VStack(spacing: -10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Your Activity")
                        .font(Font.custom("Poppins", size: 18).weight(.semibold))
                    
                    Text("Streak calendar")
                        .font(Font.custom("Poppins", size: 18).weight(.medium))
                        .foregroundColor(Color(red: 0.72, green: 0.72, blue: 0.78))
                }
                
                Spacer()
            }
            .padding(.leading, 35)
            
                Image("Calendar")
                    .resizable()
                    .frame(width: 350, height: 420)
        
        }
    }
}

#Preview {
    CalendarCardView(streak: 10, streakRecord: 10)
}
