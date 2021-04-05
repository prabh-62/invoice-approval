enum ResponseStatusType: Int, Codable {
    case Error
    case Success
}

class ResponseBase: Codable {
    var ResponseStatus: ResponseStatusType
    var ErrorMessage: String?
}

struct DocumentResponseError: Codable {
    var Message = ""
}
