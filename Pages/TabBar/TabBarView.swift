//
//  TabBarView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 20.02.2024.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @State private var selectedTab = "My Home"
    

    var body: some View {
        TabView(selection: $selectedTab) {
            MyHomeView()
                .tabItem {
                    Label("My Home", image: "Home")
                }
                .tag("My Home")

            LeaderBoardView(currentLeagueId: /*userVM.user.xp / */1000)
                .tabItem {
                    Label("Leader Board", image: "Stairs")
                }
                .tag("Leader Board")

//            CourseView(course: Course.allCourses[Array(userVM.user.coursesSuccess.keys)[0]])
//                .tabItem {
//                    Label("Courses", image: "Rocket_bar")
//                }
//                .tag("Courses")

            CommunityView()
                .tabItem {
                    Label("Community", image: "People")
                }
                .tag("Community")

            ProfileView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag("Profile")
        }
        .accentColor(.purple) // Цвет активной вкладки
    }
}

#Preview {
    TabBarView()
        .environmentObject(UserViewModel())
}
