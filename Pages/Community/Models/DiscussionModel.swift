import Foundation

struct Discussion: Identifiable, Decodable {
    let id: Int
    let title: String
    let body: String
    let date: String
    var likes: Int = 0
    let countAnswers: Int
}
