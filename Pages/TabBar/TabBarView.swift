//
//  TabBarView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 20.02.2024.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var courseVM: CourseViewModel
    @State private var selectedTab = "My Home"
    
    
    var body: some View {
        if userVM.user != nil {
            TabView(selection: $selectedTab) {
                MyHomeView()
                    .tabItem {
                        Label("My Home", image: "Home")
                    }
                    .tag("My Home")
                
                LeaderBoardView()
                    .tabItem {
                        Label("Leader Board", image: "Stairs")
                    }
                    .tag("Leader Board")
                
                CourseView(course: courseVM.userCourses.first)
                    .tabItem {
                        Label("Courses", image: "Rocket_bar")
                    }
                    .tag("Courses")
                
                CommunityView()
                    .tabItem {
                        Label("Community", image: "People")
                    }
                    .tag("Community")
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                    .tag("Profile")
            }
            .accentColor(.purple) // Цвет активной вкладки
        } else {
            Text(userVM.errorMessage!)
        }
    }
}

#Preview {
    TabBarView()
        .environmentObject(UserViewModel())
}
