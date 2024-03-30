//
//  LinkStringView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 23.02.2024.
//

import SwiftUI

struct LinkStringView: View {
    
    @State private var isShowingContactUs = false
    
    var body: some View {
        
        let plainText = "If you came across any problem just"
        let buttonText = "contact us"
        let endText = "and we’ll solve it✍️"
        
        VStack(alignment: .leading) {
            Text(plainText)
            
            HStack {
                
                Button(action: {
                    isShowingContactUs = true
                }, label: {
                    Text(buttonText)
                })
                .fullScreenCover(isPresented: $isShowingContactUs) {
                    ContactUsView()
                }

                Text(endText)
            }
        }
    }
}

#Preview {
    LinkStringView()
}
