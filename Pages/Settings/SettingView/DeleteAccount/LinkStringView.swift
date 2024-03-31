//
//  LinkStringView.swift
//  QuickSkill
//
//  Created by Али Сейфельдин on 23.02.2024.
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
                
                NavigationLink(destination: ContactUsView()) {
                    Text(buttonText)
                }

                Text(endText)
            }
        }
    }
}

#Preview {
    LinkStringView()
}
