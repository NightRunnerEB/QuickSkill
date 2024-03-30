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
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        Group {
            if isUserAuthenticated {
                MainView()
                    .onAppear {
                        userVM.getInfo()
                    }
            } else {
                PresentationView()
            }
        }
    }
}

#Preview {
    ContentView()
}
