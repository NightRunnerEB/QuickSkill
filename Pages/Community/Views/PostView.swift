//
//  DiscussionView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 28.03.2024.
//

import SwiftUI

struct PostView: View {
    @State private var isAnswering = false
    @Binding var post: Post
    @StateObject var answerVM: AnswerViewModel = AnswerViewModel()
    @State private var errorMessage: String?
    
    var body: some View {
        Group {
            if answerVM.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = answerVM.errorMessage {
                Text("An error occurred: \(errorMessage)")
            } else {
                ZStack(alignment: .bottom){
                    VStack(spacing: 15) {
                        
                        // Question
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text(post.discussion.title)
                                .font(Font.custom("Poppins", size: 17).weight(.medium))
                            
                            HStack(alignment: .bottom, spacing: 8) {
                                
                                HStack(spacing: 4.84) {
                                    Image("Like")
                                        .resizable()
                                        .frame(width: 17, height: 17)
                                    
                                    Text("\(post.discussion.likes)")
                                        .font(Font.custom("Poppins", size: 9.68))
                                }
                                .frame(width: 37.20, height: 21.78)
                                
                                Spacer()
                                
                                VStack {
                                    Text(post.discussion.date)
                                        .font(Font.custom("Poppins", size: 9.68))
                                    
                                    Text(post.author.fullName)
                                        .font(Font.custom("Poppins", size: 9.68))
                                }
                                
                                Image(post.author.icon)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 34, height: 34)
                                    .clipShape(Circle())
                                
                            }
                        }
                        .padding(24)
                        .background(Color(red: 0.99, green: 0.99, blue: 0.99))
                        .cornerRadius(15)
                        .shadow(
                            color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4
                        )
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                        
                        HStack {
                            HStack(alignment: .top, spacing: 4) {
                                HStack(spacing: 4) {
                                    Text("Popular")
                                        .font(Font.custom("Poppins", size: 12))
                                        .foregroundColor(.white)
                                    
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.white)
                                        .frame(width: 12, height: 12)
                                }
                                .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
                                .background(Color("Purple"))
                                .cornerRadius(15)
                            }
                            
                            Spacer()
                            
                            Text("\(answerVM.answers.count) answers")
                                .font(Font.custom("Poppins", size: 12))
                                .foregroundColor(.black)
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 6, trailing: 20))
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            // Section for discussions
                            VStack(spacing: 18) {
                                ForEach(answerVM.answers) { answer in
                                    AnswerCell(answerWithAuthor: answer)
                                }
                                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                            }
                        }
                        
                        
                        // New Answer Button
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                self.isAnswering = true
                            }
                        }) {
                            ZStack() {
                                
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 150, height: 45)
                                    .background(Color("Purple"))
                                    .cornerRadius(16.52)
                                
                                HStack {
                                    Image(systemName: "plus")
                                    Text("New answer")
                                }
                                .font(Font.Poppins(size: 15.73))
                                .foregroundColor(.white)
                            }
                        }
                    }
                    .blur(radius: isAnswering ? 5 : 0)
                    
                    if isAnswering {
                        GeometryReader { geometry in
                            VStack {
                                
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    
                                    NewAnswerView(answerVM: answerVM, isPresenting: $isAnswering)
                                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.5)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                        .shadow(radius: 5)
                                    
                                    Spacer()
                                }
                            }
                            
                        }
                        .background(
                            Color.white.opacity(0.1)
                                .edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                                    isAnswering = false
                                }
                        )
                    }
                }
            }
        }
        .onAppear {
            answerVM.getAnswers(discussionId: post.discussion.id)
        }
    }
    
}

struct AnswerCell: View {
    var answerWithAuthor: AnswerWithAuthor
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(answerWithAuthor.answer.body)
                .font(Font.custom("Poppins", size: 12))
            
            
            HStack(alignment: .bottom, spacing: 8) {
                
                HStack(spacing: 4.84) {
                    Image("Like")
                        .resizable()
                        .frame(width: 17, height: 17)
                    
                    Text("\(answerWithAuthor.answer.likes)")
                        .font(Font.custom("Poppins", size: 9.68))
                }
                .frame(width: 37.20, height: 21.78)
                
                Spacer()
                
                VStack {
                    Text(answerWithAuthor.answer.date)
                        .font(Font.custom("Poppins", size: 9.68))
                    
                    Text(answerWithAuthor.author.fullName)
                        .font(Font.custom("Poppins", size: 9.68))
                }
                
                Image(answerWithAuthor.author.icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 34, height: 34)
                    .clipShape(Circle())
                
            }
        }
        .padding(20)
        .background(Color(red: 0.99, green: 0.99, blue: 0.99))
        .cornerRadius(15)
        .shadow(
            color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4
        )
    }
}
//
//#Preview {
//    @State var discuss = Discussion.sampleData[0]
//    return DiscussionView(discussion: $discuss)
//}
