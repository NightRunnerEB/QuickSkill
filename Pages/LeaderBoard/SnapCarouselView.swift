//
//  SnapCarouselView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 02.03.2024.
//

import SwiftUI

struct SnapCarousel<Content: View, T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]
    
    // Properties...
    var spacing: CGFloat
    var trailingSpace: CGFloat
    var targetId: Int
    @Binding var index: Int
    
    init(spacing: CGFloat = 25, trailingSpace: CGFloat = 40, target: Int, index: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T)->Content) {
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
        self.targetId = target
    }
    
    @GestureState var offset: CGFloat = 0
    @State var currentIndex = 0
    
    var body: some View {
        
        GeometryReader{proxy in
            
            //Setting correct Width for snap Carousel
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustMentWidth = (trailingSpace / 2) - spacing
            
            HStack(spacing: spacing) {
                
                ForEach(0..<list.count, id: \.self) { index in
                    VStack {
                        content(list[index])
                            .frame(width: proxy.size.width - trailingSpace, height: 125)
                            .scaleEffect(index == targetId ? 1.4 : 1)
                            .animation(.easeOut, value: index == targetId)
                    }
                    
                }
            }
            .padding(.horizontal, spacing)
            .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustMentWidth : 0) + offset)
            .gesture(
                
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        
                        // Updating Current Index
                        let offsetX = value.translation.width
                        
                        let progress = -offsetX / width
                        
                        let roundIndex = progress.rounded()
                        
                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        
//                        currentIndex = index
                    })
                    .onChanged({ value in
                        // updating only index...
                        
                        // Updating Current Index
                        let offsetX = value.translation.width
                        
                        let progress = -offsetX / width
                        
                        let roundIndex = progress.rounded()
                        
                        index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    })
            )
        }
        .animation(.easeInOut, value: offset == 0)
        .onAppear(perform: {
            currentIndex = index
        })
    }
}

#Preview {
    @StateObject var userVM = UserViewModel()
    return LeaderBoardView(currentLeagueId: userVM.user.xp / 1000)
        .environmentObject(userVM)
}
