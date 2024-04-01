//
//  NewAnswerView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 28.03.2024.
//

import SwiftUI

struct NewAnswerView: View {
    @ObservedObject var answerVM: AnswerViewModel
    @Binding var isPresenting: Bool
    @State private var newAnswer: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Topic
            VStack(alignment: .leading, spacing: 12) {
                Text("Write your answer here ")
                    .font(Font.custom("Poppins", size: 16.47))
                
                HStack() {
                    
                    ZStack(alignment: .topLeading) {
                        if newAnswer.isEmpty {
                            Text("Your topic...")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 12)
                        }
                        TextEditor(text: $newAnswer)
                            .frame(minHeight: 40)
                            .fixedSize(horizontal: false, vertical: true)
                            .opacity(newAnswer.isEmpty ? 0.25 : 1)
                            .font(Font.custom("Poppins", size: 17))
                    }
                    
                    if(!newAnswer.isEmpty) {
                        Button(action: {
                            newAnswer = ""
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
            
            Spacer()
            
            // Answer Button
            Button(action: {
                answerVM.makeAnswer(content: newAnswer){
                    isPresenting = false
                }
            }) {
                if answerVM.isLoading {
                    ProgressView()
                        .frame(width: 150, height: 45)
                } else {
                    Text("Answer")
                        .font(Font.Poppins(size: 15.73))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100, height: 45)
                        .background(Color("Purple"))
                        .cornerRadius(16.52)
                    
                }
            }
            .padding(10)
        }
    }
}
