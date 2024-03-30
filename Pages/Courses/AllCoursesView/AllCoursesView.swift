//
//  AllCoursesView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 27.02.2024.
//

import Foundation
import SwiftUI
import PartialSheet

struct AllCoursesView: View {
    @ObservedObject var courseVM = CourseViewModel()
    
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
        VStack {
            
            // Button Back
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
                .padding(.leading, 10)
                
                Spacer()
            }
            
            CustomSearchBarView(courseVM: courseVM)
                .padding(.top, 10)
            
                ScrollView {
                    LazyVStack {
                        ForEach(courseVM.courses) { course in
                            CourseItemView(course: course)
                                .padding(.bottom, 10)
                            
                            Rectangle()
                                .foregroundColor(.gray)
                                .opacity(0.2)
                                .frame(width: 330, height: 1)
                                .padding(.bottom, 10)
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .attachPartialSheetToRoot()
    }
}

#Preview {
    AllCoursesView()
}
