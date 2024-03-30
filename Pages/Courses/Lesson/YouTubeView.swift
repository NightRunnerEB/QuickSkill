//
//  YouTubeView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 01.03.2024.
//

import SwiftUI
import WebKit

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

struct TestView: View {
    var body: some View {
        YouTubeView(videoID: "67oWw9TanOk?si=oXrKT_235DBw5fvn") // Замените на ваш videoID с YouTube
            .frame(height: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

