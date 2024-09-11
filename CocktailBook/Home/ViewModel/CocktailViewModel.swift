//
//  CocktailViewModel.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 29/08/24.
//

import Foundation
import CocktailBookAPIFramework

class CocktailViewModel {
    let cocktailsAPI: CocktailsAPI
    
    var cocktailList: [CocktailUIModel]?
    
    private var _allCocktailList: [CocktailUIModel]?
    
    private var _selectedCocktailFilter = CocktailFilterOption.all
    var selectedCocktailFilter: CocktailFilterOption {
        get {
            return _selectedCocktailFilter
        }
        set {
            if newValue != _selectedCocktailFilter || (cocktailList?.isEmpty ?? true)  {
                _selectedCocktailFilter = newValue
                cocktailList?.removeAll()
                manageUIList()
            }
        }
    }
    
    init(apiCaller: CocktailsAPI) {
        cocktailsAPI = apiCaller
    }
    
    func addToFavorite(id: String) {
        guard !CocktailFavoriteManager.instanse.isFavorite(id: id) else {
            return
        }
        
        guard let itemIndex = _allCocktailList?.firstIndex(where: {$0.id == id}) else {
            return
        }
        
        guard var item = _allCocktailList?[itemIndex] else {
            return
        }
        
        item.isFavorite = true
        
        _allCocktailList?[itemIndex] = item
        
        CocktailFavoriteManager.instanse.addToFavorite(id: id)
        
        manageUIList()
    }
    
    func removeFromFavorite(id: String) {
        guard CocktailFavoriteManager.instanse.isFavorite(id: id) else {
            return
        }
        
        guard let itemIndex = _allCocktailList?.firstIndex(where: {$0.id == id}) else {
            return
        }
        
        guard var item = _allCocktailList?[itemIndex] else {
            return
        }
        
        item.isFavorite = false
        
        _allCocktailList?[itemIndex] = item
        
        CocktailFavoriteManager.instanse.removeFromFavorite(id: id)
        
        manageUIList()
    }
    
    private func manageUIList() {
        switch _selectedCocktailFilter {
        case .all:
            cocktailList = _allCocktailList
        case .alcoholic:
            cocktailList = _allCocktailList?.filter {$0.type == .alcoholic}
        case .nonAlcoholic:
            cocktailList = _allCocktailList?.filter {$0.type == .nonAlcoholic}
        }
        
        var iIterator = (cocktailList?.count ?? .zero) - 1
        var shiftedItemCount = 0
        while(iIterator > shiftedItemCount) {
            if let item = cocktailList?[iIterator], item.isFavorite {
                cocktailList?.remove(at: iIterator)
                cocktailList?.insert(item, at: .zero)
                shiftedItemCount += 1
            }
            iIterator -= 1
        }
    }
    
    func fetch(completionHandler: @escaping (Bool, CocktailError?)->()) {
        cocktailsAPI.fetchCocktails { [weak self] result in
            switch result {
            case .success(let data):
                guard let jsonObj = try? JSONDecoder().decode([CocktailModel].self, from: data) else {
                    completionHandler(false, .jsonParsing)
                    return
                }
                self?._allCocktailList = jsonObj.compactMap({ item in
                    CocktailUIModel(cocktail: item)
                }).sorted { ($0.name ?? .empty) < ($1.name ?? .empty) }
                self?.selectedCocktailFilter = .all
                completionHandler(true, nil)
                
            case .failure(_):
                completionHandler(false, .networkFailure)
            }
        }
    }
}
