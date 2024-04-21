//
//  ContentView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 10.02.2024.
//

import SwiftUI
import PartialSheet

struct ContentView: View {
    @AppStorage("isUserAuthenticated") var isUserAuthenticated: Bool = false
    @AppStorage("NotificationPermission") var isNotificationPermitted: Bool = false
    @EnvironmentObject var userVM: UserViewModel
    @StateObject var courseVM = CourseViewModel()
    
    var body: some View {
        Group {
            if isUserAuthenticated {
                MainView()
                    .onAppear {
                        userVM.getInfo()
                    }
                    .environmentObject(courseVM)
            } else {
                PresentationView()
            }
        }
    }
}

#Preview {
    ContentView()
}
