//
//  UserDefaultUtils.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/22/24.
//

import Foundation

class UserDefaultUtils {
    
    private init() { }
    
    @UserDefault(key: "user", defaultValue: User(nickname: "", profileImageIndex: -1))
    static var user: User
    
    @UserDefault(key: "searchLogs", defaultValue: [])
    static var searchLogs: [SearchLog] {
        didSet {
            keyOfsearchLogsSet = Set(searchLogs.map { $0.keyword })
            searchLogsHandler?()
        }
    }
    
    // 최근 검색어의 keyword만 모은 집합
    static var keyOfsearchLogsSet: Set<String> = Set(searchLogs.map { $0.keyword })
    
    static var searchLogsHandler: (() -> Void)?
    
    @UserDefault(key: "wishes", defaultValue: [])
    static var wishes: Set<String>
    
    static func reset() {
        user = User(nickname: "", profileImageIndex: -1)
        searchLogs.removeAll()
        wishes.removeAll()
    } 
}

@propertyWrapper
struct UserDefault<T: Codable> {
    private let key: String
    private let defaultValue: T
    public let storage: UserDefaults
    
    init(key: String, defaultValue: T, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
    
    var wrappedValue: T {
        get {
            guard let data = self.storage.object(forKey: key) as? Data else {
                return defaultValue
            }
            
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
