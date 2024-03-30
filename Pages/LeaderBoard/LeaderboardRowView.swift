//
//  LeaderboardRow.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 03.03.2024.
//

import SwiftUI

struct LeaderboardFriendRow: View {
    
    var user: User
    
    var body: some View {
        HStack {
                    
            Image(user.photo)
                .resizable()
                .clipShape(Rectangle())
                .cornerRadius(10.91)
                .overlay(
                  RoundedRectangle(cornerRadius: 10.91)
                    .inset(by: 1.2)
                    .stroke(Color(red: 1, green: 1, blue: 1), lineWidth: 1.2)
                )
                .shadow(
                  color: Color(red: 1, green: 1, blue: 1, opacity: 1), radius: 4
                )
                .frame(width: 55, height: 55)
                
            Text(user.firstName + " " + user.lastName)
                .font(Font.custom("Poppins", size: 17).weight(.medium))
                .padding(.leading, 4)
            
            Spacer()
            Image(systemName: League.leagues[user.xp / 1000].leagueImage)
                .resizable()
                .frame(width: 35, height: 35)
            Text(String(format: "%.1f", Double(user.xp)/1000) + "k")
        }
        .padding()
    }
}

struct LeaderboardRow: View {
    
    var user: User
    var rank: Int = 3
    
    private var strokeColor: Color {
        switch rank {
        case 0:
            // Золотой цвет
            return Color(red: 1, green: 0.84, blue: 0)
        case 1:
            // Серебряный цвет
            return Color(red: 0.4, green: 0.7, blue: 1)
        case 2:
            // Бронзовый цвет
            return Color(red: 0.8, green: 0.5, blue: 0.2)
        default:
            // Обычный цвет
            return Color(red: 1, green: 1, blue: 1)
        }
    }
    
    var body: some View {
        
        HStack {
            Image(user.photo)
                .resizable()
                .clipShape(Rectangle())
                .cornerRadius(10.91)
                .overlay(
                  RoundedRectangle(cornerRadius: 10.91)
                    .inset(by: 1.2)
                    .stroke(strokeColor, lineWidth: 1.2)
                )
                .shadow(
                    color: strokeColor, radius: 5
                )
                .frame(width: 55, height: 55)
                
            Text(user.firstName + " " + user.lastName)
                .font(Font.custom("Poppins", size: 17).weight(.medium))
            
            Spacer(minLength: 20)

            Text(String(format: "%.1f", Double(user.xp)/1000) + "k")
        }
        .padding()
    }
}

#Preview {
    @StateObject var userVM = UserViewModel()
    return LeaderboardFriendRow(user: userVM.user)
        .environmentObject(userVM)
}

#Preview {
    @StateObject var userVM = UserViewModel()
    return LeaderboardRow(user: userVM.user, rank: 5)
        .environmentObject(userVM)
}
