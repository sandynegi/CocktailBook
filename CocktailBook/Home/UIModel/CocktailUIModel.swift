//
//  CocktailUIModel.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 29/08/24.
//

import Foundation

struct CocktailUIModel {
    let id: String?
    let name: String?
    let type: AlcoholicType?
    let shortDescription: String?
    let longDescription: String?
    let preparationMinutes: Int?
    let imageName: String?
    let ingredients: [String]?
    var isFavorite: Bool
    
    init(cocktail: CocktailModel) {
        self.id = cocktail.id
        self.name = cocktail.name
        self.type = cocktail.type
        self.shortDescription = cocktail.shortDescription
        self.longDescription = cocktail.longDescription
        self.preparationMinutes = cocktail.preparationMinutes
        self.imageName = cocktail.imageName
        self.ingredients = cocktail.ingredients
        self.isFavorite = CocktailFavoriteManager.instanse.isFavorite(id: cocktail.id ?? .empty)
    }
}
