//
//  DetailView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 20.03.2024.
//

import SwiftUI

struct DetailView: View {
    @Binding var isSearchViewVisible: Bool
    @ObservedObject var courseVM: CourseViewModel = CourseViewModel()
    @State private var isPresentedAllCourses = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                Button(action: {
                        isPresentedAllCourses = true
                }, label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                            .frame(width: 30, alignment: .leading)
                        
                        Text("Search courses")
                            .font(.headline)
                            .layoutPriority(1)
                        
                        Spacer()
                    }
                    .padding()
                })
                .accentColor(.gray)
                .fullScreenCover(isPresented: $isPresentedAllCourses, content: {
                    AllCoursesView()
                })
                
                ForEach(courseVM.allCourses) { course in
                    HStack {
                        Image(course.media)
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        
                        Text(course.name)
                            .font(.headline)
                            .layoutPriority(1)
                        
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                }
                .navigationBarTitle("Courses")
            }
        }
        .onAppear {
            courseVM.getCourses()
        }
    }
}

#Preview {
    @State var val = false
    return DetailView(isSearchViewVisible: $val)
}
