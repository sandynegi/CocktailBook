//
//  StorageHelper.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 30/08/24.
//

import Foundation

final class StorageHelper {
    static func saveFavorite(items: [String]) -> Bool {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: AppConstants.StorageKeys.favoriteList)
            UserDefaults.standard.synchronize()
            return true
        }
        return false
    }
    
    static func favoriteList() -> Set<String>? {
        if let data = UserDefaults.standard.data(forKey: AppConstants.StorageKeys.favoriteList) {
            if let decoded = try? JSONDecoder().decode([String].self, from: data) {
                return Set(decoded)
            }
        }
        return nil
    }
}
