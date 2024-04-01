//
//  PracticeView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 05.03.2024.
//

import SwiftUI
import PartialSheet

struct PracticeView: View {
    @EnvironmentObject var userVM: UserViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject var quizVM = QuizViewModel()
    var course: Course
    @Binding var topic: Topic
    @State private var isExplanationPresented = false
    @State private var isQuizCompleted = false
    @State private var progress: Double = 0
    @State private var error = false
    
    var body: some View {
        Group {
            if let error = quizVM.errorMessage {
                Text("An error occurred: \(error) ?? Unknown error")
            } else if let questions = quizVM.questions {
                VStack {
                    HeaderView(progress: $progress)
                    
                    Spacer()
                    if quizVM.quizCompleted {
                        Group {
                            QuizResultView(score: quizVM.score, crystals: quizVM.crystals, success: Double(quizVM.success) / Double(questions.count) * 100)
                                .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                            
                            Button("Back") {
                                dismiss()
                            }
                            .buttonStyle(PrimaryButtonStyle())
                            
                            Spacer()
                        }
                        .animation(.easeInOut(duration: 1.0), value: quizVM.quizCompleted)
                    } else {
                        QuestionView(question: quizVM.getCurrentQuestion()!, selectedAnswer: $quizVM.selectedAnswer, answerChecked: quizVM.isAnswered)
                        
                        
                        Spacer()
                        
                        if !quizVM.isAnswered {
                            // Кнопка "Check" отображается, если вопрос еще не был проверен
                            VStack {
                                Button("Check") {
                                    if quizVM.selectedAnswer == nil {
                                        error = true
                                    } else {
                                        error = false
                                        progress += 1 / Double(quizVM.questions!.count)
                                        quizVM.checkAnswer()
                                    }
                                }
                                .buttonStyle(PrimaryButtonStyle())
                                .padding(.bottom, 15)
                                
                                if error {
                                    Text("Choose answer!")
                                }
                            }
                        } else {
                            HStack(spacing: 30) {
                                Button("Explain") {
                                    // Открыть полноэкранное представление с объяснением
                                    isExplanationPresented = true
                                }
                                .buttonStyle(PrimaryButtonStyle())
                                
                                if quizVM.currentQuestionIndex == quizVM.questions!.count - 1 {
                                    Button("Finish" ) {
                                        course.progress += 7
                                        topic.blocked = false
                                        quizVM.quizCompleted = true
                                    }
                                    .buttonStyle(PrimaryButtonStyle())
                                    
                                } else {
                                    Button("Continue") {
                                        // Переход к следующему вопросу
                                        quizVM.goToNextQuestion()
                                    }
                                    .buttonStyle(SecondaryButtonStyle())
                                }
                            }
                            .padding(.bottom, 15)
                        }
                    }
                }
                .fullScreenCover(isPresented: $isExplanationPresented, content: ExplanationView.init)
            } else {
                ProgressView("Loading...")
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .attachPartialSheetToRoot()
        .onAppear {
            quizVM.loadQuestions(courseId: course.id)
        }
    }
}

struct HeaderView: View {
    @Binding var progress: Double
    @State var isPresentedAnswer = false
    @State var isPresentedHearts = false
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        HStack {
            
            Spacer()
            
            PSButton(
                isPresenting: $isPresentedHearts,
                label: {
                    HStack {
                        Text("❤️")
                        Text("\(userVM.user.energy)")
                    }
                    .frame(width: 70)
                })
            .partialSheet(
                isPresented: $isPresentedHearts,
                content: SheetBattery.init
            )
            
            Spacer()
            
            ProgressBar(progress: progress)
                .frame(width: 35)
                .padding(.horizontal, 40)
            
            Spacer()
            
            PSButton(
                isPresenting: $isPresentedAnswer,
                label: {
                    Image("Unlock Private")
                        .frame(width: 70)
                })
            .partialSheet(
                isPresented: $isPresentedAnswer,
                content: UnlockView.init
            )
            
            Spacer()
        }
        .padding()
    }}

struct ProgressBar: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .opacity(0.3)
                .foregroundColor(Color("Purple"))
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("Purple"))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
        }
    }
}

struct QuestionView: View {
    let question: Question
    @Binding var selectedAnswer: Int?
    var answerChecked: Bool
    
    var body: some View {
        VStack {
            // Отображение текущего вопроса
            Text(question.text)
                .font(Font.custom("Poppins", size: 16))
                .multilineTextAlignment(.center)
            
            let columns: [GridItem] = [
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
            // Представление списка возможных ответов
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Array(question.answers.enumerated()), id: \.element) { index, answer in
                    Button(action: {
                        selectedAnswer = index
                    }) {
                        Text(answer)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(answerChecked && index == question.correctAnswer ? Color.green : (index == selectedAnswer ? Color("Purple") : Color("Purple").opacity(0.2)))
                            .foregroundColor(index == selectedAnswer ? Color.white : Color("Purple"))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(answerChecked && index == selectedAnswer && index != question.correctAnswer ? Color.red : Color.clear, lineWidth: 3)
                            )
                    }
                    .disabled(answerChecked)
                }
                .padding()
            }
        }
    }
}

struct QuizResultView: View {
    @EnvironmentObject var userVM: UserViewModel
    var score: Int
    var crystals: Int
    var success: Double
    
    var body: some View {
        // Представление результатов викторины
        VStack(spacing: 20) {
            Text("Test completed!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .background(Color.purple.opacity(0.2))
                .cornerRadius(12)

            VStack {
                Text("Answer accuracy:")
                    .font(.title2)
                HStack(spacing: 4) {
                    Text("\(success, specifier: "%.0f") %")
                        .font(Font.custom("Inter", size: 12))
                    
                    ProgressView(value: success, total: 100)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color.green))
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                }
            }

            VStack {
                Text("Earned XP:")
                    .font(.title2)
                Text("\(score)")
                    .fontWeight(.semibold)
                    .padding(22)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.orange, lineWidth: 5)
                    )
            }

            VStack {
                Text("Earned Crystals:")
                    .font(.title2)
                Text("\(crystals)")
                    .fontWeight(.semibold)
                    .padding(22)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: 5)
                    )
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.purple]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(15)
        .shadow(
            color: Color(red: 0, green: 0, blue: 0, opacity: 0.17), radius: 4.84, y: 4.84
        )
        .onAppear{
            userVM.addResults(xp: score, crystals: crystals)
            userVM.user.energy -= 1
        }
    }
}

struct ExplanationView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 17.44, height: 17.44)
                        .foregroundStyle(.black)
                })
                
                Spacer()
            }
            .padding(.leading, 27)
            .padding(.bottom, 10)
            
            
            Text("Здесь будет объяснение ответа.")
        }
    }
}

struct UnlockView: View {
    var body: some View {
        // Содержимое представления, показываемого при нажатии на кнопку "Объяснить"
        Text("Нужен ответ? Заплати пени!")
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 120, height: 50)
            .background(Color.backgroundPurple)
            .foregroundColor(Color("Purple"))
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 120, height: 50)
            .background(Color.green.opacity(0.2))
            .foregroundColor(Color.green)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
//
//#Preview {
//    PracticeView()
//        .environmentObject(UserViewModel())
//}

#Preview {
    QuizResultView(score: 3000, crystals: 200, success: 40)
        .environmentObject(UserViewModel())
}
