//
//  LessonView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 01.03.2024.
//

import SwiftUI
import WebKit

struct LectureView: View {
    let videoID = "67oWw9TanOk?si=oXrKT_235DBw5fvn"
    @Binding var lesson: Lesson
    @StateObject var lectureVM = LectureViewModel()
    @State private var isExpandedTranscipt = true
    @State private var isExpandedNotes = true
    @Binding var topic: Topic
    var course: Course
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Group {
            VStack(spacing: 5) {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack {
                        
                        Text(topic.name)
                            .font(Font.custom("Poppins", size: 27).weight(.medium))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text("Lesson \(lesson.id + 1)")
                            .font(Font.custom("Poppins", size: 15))
                            .foregroundColor(Color("Purple"))
                    }
                    
                    Text(lesson.name)
                        .font(Font.custom("Poppins", size: 17))
                        .foregroundColor(.black)
                }
                .padding()
                
                YouTubeView(videoID: videoID)
                    .frame(height: 200)
                
                CustomDisclosureGroup(title: "Transcript", isExpanded: $isExpandedTranscipt) {
                        Text(lectureVM.transcript)
                            .fixedSize(horizontal: false, vertical: true)
                }
                
                CustomDisclosureGroup(title: "Notes", isExpanded: $isExpandedNotes) {
                    Text(lectureVM.notes)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                }
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        HStack {
                            Text("To Previous Lesson")
                                .font(Font.custom("Poppins", size: 14))
                                .foregroundColor(Color("Purple"))
                        }
                        .padding(
                            EdgeInsets(top: 4.81, leading: 13.40, bottom: 4.81, trailing: 13.40)
                        )
                        .background(Color("Background-purple"))
                        .cornerRadius(10)
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        course.progress += 7
                        topic.content[lesson.id + 1].blocked = false
                        dismiss()
                    }, label: {
                        HStack {
                            Text("Go to practice")
                                .font(Font.custom("Poppins", size: 14))
                                .foregroundColor(Color("Purple"))
                        }
                        .padding(
                            EdgeInsets(top: 4.81, leading: 13.40, bottom: 4.81, trailing: 13.40)
                        )
                        .background(Color("Background-purple"))
                        .cornerRadius(10)
                    })
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .onAppear{
            lectureVM.getNotes(lessonId: lesson.id)
            lectureVM.getTranscript(lessonId: lesson.id)
        }
    }
}

struct YouTubeView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
}

struct CustomDisclosureGroup<Content: View>: View {
    let title: String
    @Binding var isExpanded: Bool
    let content: Content
    
    init(title: String, isExpanded: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.title = title
        self._isExpanded = isExpanded
        self.content = content()
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                
                    .font(.headline)
                
                Image(systemName: "chevron.right")
                    .rotationEffect(.degrees(isExpanded ? 90 : 0))
                
                Spacer()
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            if isExpanded {
                ScrollView {
                    content
                        .padding(EdgeInsets(top: 7, leading: 15, bottom: 7, trailing: 15))
                }
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .accentColor(.black)
    }
}

//#Preview {
//    @State var topic = Topic.topics[1]
//    @State var lesson = Lesson.sampleData[0]
//    return LectureView(lesson: $lesson, topic: $topic)
//}
