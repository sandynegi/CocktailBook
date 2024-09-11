//
//  DetailUIViewModel.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 30/08/24.
//

import Foundation

enum DetailScreenRowType: Int {
    case none = -1
    case iconText = 0
    case banner = 1
    case text = 2
    case header = 3
}

struct DetailScreenDisplayRow {
    let icon: String
    let text: String
    let type: DetailScreenRowType
}

class DetailUIViewModel {
    var rows = [DetailScreenDisplayRow]()
}
