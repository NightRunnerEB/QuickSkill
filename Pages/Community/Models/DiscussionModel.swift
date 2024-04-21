import Foundation

struct Discussion: Identifiable, Decodable {
    let id: Int
    let title: String
    let body: String
    var likes: Int = 0
    let answersCount: Int
    let publishedOn: String
}
