//
//  CourseItemView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 27.02.2024.
//

import SwiftUI

struct CourseItemView: View {
    let course: Course
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 8) {
                Image(course.icon)
                
                VStack(alignment: .leading) {
                    Text(course.title)
                        .font(Font.Poppins(size: 17).weight(.semibold))
                    
                    Text(course.type)
                        .font(Font.Poppins(size: 17)).opacity(0.35)
                }
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    HStack(spacing: 10) {
                      Text("Start")
                        .font(Font.custom("Poppins", size: 17).weight(.semibold))
                        .foregroundColor(Color("Purple"))
                    }
                    .frame(width: 106, height: 36)
                    .background(Color(red: 0.41, green: 0.05, blue: 0.92).opacity(0.15))
                    .cornerRadius(24)
                    .shadow(
                      color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 4, y: 4
                    )
                })
            }
            
            Text(course.description)
                .font(Font.Poppins(size: 17).weight(.light))
        }
        .padding(7)
    }
}

#Preview {
    CourseItemView(course: Course.allCourses[0])
}
