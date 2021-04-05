import Foundation

struct DocumentLog: Codable {
    var Id: Int = 0
    var Created: Date?
    var Creator: String?
    var Text: String?
}

public struct DocumentComment: Codable, Hashable {
    var feedback: String
}

public struct DocumentCommentResponse: Codable, Hashable {
    var IsSubmitted = false
}
