//
//  CocktailModel.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 29/08/24.
//

import Foundation

enum AlcoholicType: String, Decodable {
    case alcoholic = "alcoholic"
    case nonAlcoholic = "non-alcoholic"
}

struct CocktailModel: Decodable {
    let id: String?
    let name: String?
    let type: AlcoholicType?
    let shortDescription: String?
    let longDescription: String?
    let preparationMinutes: Int?
    let imageName: String?
    let ingredients: [String]?
}
