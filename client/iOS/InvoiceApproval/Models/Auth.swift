import Foundation

public struct LoginCredentials: Codable {
    var UserName: String
    var Password: String
    var Devicetoken: String
}

public struct LoginResponse: Codable {
    var BellatrixToken: String
}

public struct LogOutResponse: Codable {
    var IsLogout: Bool
}

public class UserAuth: ObservableObject {
    @Published var accessToken: String?
}
