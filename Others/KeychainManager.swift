import KeychainSwift

class KeychainManager {
    static let shared = KeychainManager()
    private let keychain = KeychainSwift()
    private let tokenKey = "userToken"
    private let refreshTokenKey = "refreshToken"

    /// Сохраняет токен пользователя в Keychain.
    /// - Parameter token: Токен пользователя для сохранения.
    func saveUserToken(_ token: String) {
        keychain.set(token, forKey: tokenKey)
    }
    
    /// Сохраняет refresh токен в Keychain.
    /// - Parameter token: Refresh токен  для сохранения.
    func saveRefreshToken(_ token: String) {
        keychain.set(token, forKey: refreshTokenKey)
    }

    /// Извлекает токен пользователя из Keychain.
    /// - Returns: Токен пользователя, если он сохранен, иначе `nil`.
    func getUserToken() -> String? {
        return keychain.get(tokenKey)
    }
    
    /// Извлекает refresh токен  из Keychain.
    /// - Returns: Refresh токен, если он сохранен, иначе `nil`.
    func getRefreshToken() -> String? {
        return keychain.get(refreshTokenKey)
    }

    /// Удаляет токен пользователя из Keychain.
    func deleteUserToken() {
        keychain.delete(tokenKey)
    }
}


