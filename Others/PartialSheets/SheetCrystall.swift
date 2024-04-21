//
//  SheetCrystal.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 25.03.2024.
//

import SwiftUI
import PartialSheet

struct SheetCrystal: View {
    @State private var isPresentedGetPro = false
    
    var body: some View {
        VStack(spacing: 7) {
            
            Image("Crystall")
                .resizable()
                .frame(width: 40, height: 59.57)
            
            Text("Crystals")
                .font(Font.Poppins(size: 20).weight(.light))
            .foregroundColor(.black)
            
            Text("Crystals are widely used across the application.\nUse crystals to buy freezer and hearts!")
                .multilineTextAlignment(.center)
            .font(Font.custom("Poppins", size: 13).weight(.medium))
            .foregroundColor(Color.gray)
            
            NavigationLink(destination: ShopView(), label: {
                HStack(spacing: 10.51) {
                    Image(systemName: "cart.fill")
                        .resizable()
                        .frame(width: 21, height: 21)
                        .foregroundStyle(Color("Purple"))
                    
                    Text("Shop")
                        .font(Font.custom("Inter", size: 17).weight(.semibold))
                        .foregroundColor(Color("Purple"))
                }
                .padding(
                    EdgeInsets(top: 13.66, leading: 21.01, bottom: 13.66, trailing: 21.01)
                )
                .frame(width: 134.54, height: 45)
                .background(Color("Background-purple"))
                .cornerRadius(10.51)
            })
            .padding(.top, 5)
            
            Divider()
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
            Text("Get x2 crystals with premium")
                .font(Font.Poppins(size: 13).weight(.light))
                .lineSpacing(18)
                .foregroundColor(Color.gray)
            
            Button(action: {
                isPresentedGetPro = true
            }, label: {
                Text("Subscribe")
                  .font(Font.Poppins(size: 20.66).weight(.medium))
                  .padding(
                    EdgeInsets(top: 11, leading: 19, bottom: 11, trailing: 19)
                  )
                  .foregroundColor(.white)
                  .background(Color(red: 1, green: 0.84, blue: 0))
                  .cornerRadius(10.51)
            })
            .fullScreenCover(isPresented: $isPresentedGetPro, content: {
                GetProView()
            })
            
            Spacer()
                .frame(height: 10)
        }
        .padding(.horizontal, 10)
    }
}
