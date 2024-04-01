import Foundation

struct AnswerWithAuthor: Identifiable, Decodable {
    var id: UUID = UUID()
    var answer: Answer
    var author: Author
    
    static let sampleData: [AnswerWithAuthor] = [
        AnswerWithAuthor(answer: Answer(id: 1, body: "This is an first answer content", date: "2024/04/08", likes: 10), author: Author(id: 1, photo: "Окунь", firstName: "Aleksey", lastName: "Kiselev")),
        AnswerWithAuthor(answer: Answer(id: 2, body: "Cloud computing has revolutionized the way we store and access data. By utilizing cloud services, businesses can scale their resources on demand, improving efficiency and reducing costs.", date: "2024/04/09", likes: 5), author: Author(id: 2, photo: "Окунь1", firstName: "Jane", lastName: "Smith")),
        AnswerWithAuthor(answer: Answer(id: 3, body: "Artificial intelligence is changing the landscape of various industries, from healthcare to finance. AI systems can analyze large datasets quickly and with high accuracy, leading to more informed decision-making.", date: "2024/04/10", likes: 3), author: Author(id: 3, photo: "Окунь", firstName: "Emily", lastName: "Stone")),
        AnswerWithAuthor(answer: Answer(id: 4, body: "As digital threats evolve, cybersecurity remains a critical priority for companies of all sizes.", date: "2024/04/11", likes: 8), author: Author(id: 4, photo: "Окунь1", firstName: "Lana", lastName: "Rhoades")),
        AnswerWithAuthor(answer: Answer(id: 5, body: "Originally developed for Bitcoin, blockchain technology has found applications far beyond cryptocurrencies. It offers a secure, transparent way to record transactions, which is particularly valuable in supply chain management and secure voting systems. Blockchain's decentralized nature reduces the risk of data tampering, enhancing trust in digital interactions.", date: "2024/04/12", likes: 7), author: Author(id: 5, photo: "Окунь", firstName: "Olivia", lastName: "Black"))
    ]
}

struct Answer: Identifiable, Decodable {
    let id: Int
    let body: String
    let date: String
    let likes: Int
}

