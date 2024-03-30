//
//  ProLinkStringView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 26.02.2024.
//

import SwiftUI

struct ProLinkStringView: View {
    
    @State private var isShowingGetPro = false
    
    var body: some View {
        
        let plainText = "Improve your experience in QuickSkill with"
        let buttonText = "PRO"
        let endText = "status"
        
        HStack {
            Text(plainText)
            
            
            Button(action: {
                isShowingGetPro = true
            }, label: {
                Text(buttonText)
            })
            .fullScreenCover(isPresented: $isShowingGetPro) {
                GetProView()
            }
            
            Text(endText)
            
        }
        .font(Font.Poppins(size: 12).weight(.light))
    }
}

#Preview {
    ProLinkStringView()
}
