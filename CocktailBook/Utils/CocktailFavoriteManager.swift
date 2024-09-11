//
//  CocktailFavoriteManager.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 30/08/24.
//

import Foundation

final class CocktailFavoriteManager {
    public static let instanse = CocktailFavoriteManager()
    private var _list: Set<String>
    
    private init() {
        _list = StorageHelper.favoriteList() ?? Set<String>()
        debugPrint(_list)
    }
    
    func isFavorite(id: String) -> Bool {
        return _list.contains(id)
    }
    
    @discardableResult
    func addToFavorite(id: String) -> Bool {
        var status = true
        if !id.isEmpty, !self.isFavorite(id: id) {
            _list.insert(id)
            status = StorageHelper.saveFavorite(items: Array(_list))
            debugPrint(_list)
        }
        return status
    }
    
    @discardableResult
    func removeFromFavorite(id: String) -> Bool {
        var status = true
        if !id.isEmpty, self.isFavorite(id: id) {
            _list.remove(id)
            status = StorageHelper.saveFavorite(items: Array(_list))
            debugPrint(_list)
        }
        return status
    }
    
    @discardableResult
    func clearAll() -> Bool {
        _list.removeAll()
        let status = StorageHelper.saveFavorite(items: [])
        debugPrint(_list)
        return status
    }
    
    var count: Int {
        _list.count
    }
}
