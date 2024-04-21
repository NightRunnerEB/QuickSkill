//
//  NewDiscussionView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 28.03.2024.
//

import SwiftUI

struct NewPostView: View {
    @Binding var isPresented: Bool
    @ObservedObject var postVM: PostViewModel
    @State private var topic = ""
    @State private var tags = ""
    @State private var question = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                
                // Topic
                VStack(alignment: .leading, spacing: 12) {
                    Text("Topic")
                        .font(Font.custom("Poppins", size: 24.24))
                        .foregroundColor(.black)
                    
                    HStack() {
                        
                        ZStack(alignment: .topLeading) {
                            if topic.isEmpty {
                                Text("Your topic...")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 12)
                            }
                            TextEditor(text: $topic)
                                .frame(minHeight: 40)
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(topic.isEmpty ? 0.25 : 1)
                                .font(Font.custom("Poppins", size: 17))
                        }
                        
                        if(!topic.isEmpty) {
                            Button(action: {
                                topic = ""
                            }, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.small)
                                    .foregroundStyle(Color.gray)
                            })
                        }
                    }
                    .foregroundColor(.black)
                    .padding(15)
                    .background(Color.white)
                    .cornerRadius(18.15)
                    .shadow(
                        color: Color(red: 0, green: 0, blue: 0, opacity: 0.17), radius: 4.84, y: 4.84
                    )
                }
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
                
                // Tag
                VStack(alignment: .leading, spacing: 12) {
                    Text("Related tags")
                        .font(Font.custom("Poppins", size: 24.24))
                        .foregroundColor(.black)
                    
                    HStack() {
                        ZStack(alignment: .topLeading) {
                            if tags.isEmpty {
                                Text("e.g. ‘binary search’, ‘strings’")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 12)
                            }
                            TextEditor(text: $tags)
                                .frame(minHeight: 40)
                                .fixedSize(horizontal: false, vertical: true)
                                .opacity(tags.isEmpty ? 0.25 : 1)
                                .font(Font.custom("Poppins", size: 17))
                        }
                        
                        if(!tags.isEmpty) {
                            Button(action: {
                                tags = ""
                            }, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.small)
                                    .foregroundStyle(Color.gray)
                            })
                        }
                    }
                    .foregroundColor(.black)
                    .padding(15)
                    .background(Color.white)
                    .cornerRadius(18.15)
                    .shadow(
                        color: Color(red: 0, green: 0, blue: 0, opacity: 0.17), radius: 4.84, y: 4.84
                    )
                }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                
                // Question
                VStack(alignment: .leading, spacing: 12) {
                    Text("Question")
                        .font(Font.custom("Poppins", size: 24.24))
                        .foregroundColor(.black)
                    
                HStack() {
                    ZStack(alignment: .topLeading) {
                        if question.isEmpty {
                            Text("📎  Enter your question")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 12)
                        }
                        TextEditor(text: $question)
                            .frame(minHeight: 220)
                            .opacity(question.isEmpty ? 0.25 : 1)
                            .font(Font.custom("Poppins", size: 17))
                    }
                    
                    if(!question.isEmpty) {
                        Button(action: {
                            question = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.small)
                                .foregroundStyle(Color.gray)
                        })
                    }
                }
                .foregroundColor(.black)
                .padding(15)
                .background(Color.white)
                .cornerRadius(18.15)
                .shadow(
                    color: Color(red: 0, green: 0, blue: 0, opacity: 0.17), radius: 4.84, y: 4.84
                )
            }
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                
                
                // Post Button
                Button(action: {
                    postVM.makePost(topic: topic, description: question)
                    isPresented = false
                }) {
//                    if postVM.isLoading {
//                        ProgressView()
//                            .frame(width: 150, height: 45)
//                    } else {
                        Text("Post")
                            .font(Font.Poppins(size: 15.73))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 125.58, height: 52.88)
                            .background(Color("Purple"))
                            .cornerRadius(16.52)
//                    }
                }
                .padding(6)
            }
        }
    }
}
//
//#Preview {
//    @StateObject var discussionVM: DiscussViewModel = DiscussViewModel()
//    @State var isPres = false
//    return NewDiscussionView(isPresented: $isPres, discussVM: discussionVM)
//}
