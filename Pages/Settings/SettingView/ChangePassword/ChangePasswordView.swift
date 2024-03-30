//
//  ChangePasswordView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 23.02.2024.
//

import SwiftUI

struct ChangePasswordView: View {

    @EnvironmentObject var userVM: UserViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
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
                .padding(.top, 5)
                
                Spacer()
            }
            
            Spacer()
            
            Text("В процессе разработки🍻")
            
            Spacer()
        }
    }
}

#Preview {
    ChangePasswordView()
        .environmentObject(UserViewModel())
}
