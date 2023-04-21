//
//  StorageManager.swift
//  UserDefaultsDemo
//
//  Created by Dmitrii Tikhomirov on 4/21/23.
//

import Foundation

//MARK: - CreateReadUpdateDelete
protocol StorageManagerProtocol {
    //Create & Update
    func set(_ object: Any?, forKey key: StorageManager.Keys)
    func set<T: Encodable>(object: T?, forKey key: StorageManager.Keys)
    
    //Read
    func int(forKey key: StorageManager.Keys) -> Int?
    func string(forKey key: StorageManager.Keys) -> String?
    func dict(forKey key: StorageManager.Keys) -> [String: Any]?
    func date(forKey key: StorageManager.Keys) -> Date?
    func bool(forKey key: StorageManager.Keys) -> Bool?
    func data(forKey key: StorageManager.Keys) -> Data?
    func codableData<T: Decodable>(forKey key: StorageManager.Keys) -> T?
    
    //Delete
    func remove(forKey key: StorageManager.Keys)
}

final class StorageManager {
    
    public enum Keys: String {
        case textFieldText
    }
    
    private let userDefaults = UserDefaults.standard
    
    private func store(_ object: Any?, key: String) {
        userDefaults.set(object, forKey: key)
    }
    
    private func restore(forkey key: String) -> Any? {
        userDefaults.object(forKey: key)
    }
}

//MARK: - StorageManagerProtocol
extension StorageManager: StorageManagerProtocol {
    
    //Create & Update
    func set(_ object: Any?, forKey key: Keys) {
        store(object, key: key.rawValue)
    }
    
    func set<T: Encodable>(object: T?, forKey key: Keys) {
        let jsonData = try? JSONEncoder().encode(object)
        store(jsonData, key: key.rawValue)
    }
    
    //Read
    func int(forKey key: Keys) -> Int? {
        restore(forkey: key.rawValue) as? Int
    }
    
    func string(forKey key: Keys) -> String? {
        restore(forkey: key.rawValue) as? String
    }
    
    func dict(forKey key: Keys) -> [String : Any]? {
        restore(forkey: key.rawValue) as? [String : Any]
    }
    
    func date(forKey key: Keys) -> Date? {
        restore(forkey: key.rawValue) as? Date
    }
    
    func bool(forKey key: Keys) -> Bool? {
        restore(forkey: key.rawValue) as? Bool
    }
    
    func data(forKey key: Keys) -> Data? {
        restore(forkey: key.rawValue) as? Data
    }
    
    func codableData<T: Decodable>(forKey key: Keys) -> T? {
        guard let data = restore(forkey: key.rawValue) as? Data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    //Delete
    func remove(forKey key: Keys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
