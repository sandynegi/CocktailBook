//
//  AppConstants.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 28/08/24.
//

import Foundation

enum AppConstants {
    
    enum StoryboardName {
        static let main = "Main"
    }
    
    enum StoryboardId {
        static let navigationController = "screen_navigation_controller"
        static let home = "screen_home"
        static let detail = "screen_detail"
    }
    
    enum ImageName {
        static let heartEmpty = "heart"
        static let heartFill = "heart.fill"
        static let clock = "clock"
        static let rightArrowFilled = "arrowtriangle.right.fill"
        static let chevronBackward = "chevron.backward"
    }
    
    enum TableViewCellIdentifier {
        static let cocktailItem = "CocktailTableViewCell"
        static let detailIconText = "DetailIconTextTableViewCell"
        static let detailBanner = "DetailBannerTableViewCell"
    }
    
    enum StorageKeys {
        static let favoriteList = "kfavoriteList"
    }
    
    enum ColorName {
        static let accent = "AccentColor"
        static let title = "TitleColor"
        static let content = "ContentColor"
    }
    
    enum Accessibility {
        static let scCocktailOptions = "segment_control_cocktail_options"
        static let tvCocktailTable = "table_view_cocktail_list"
        static let tvDetailTable = "table_view_cocktail_detail"
        static let lblEmptyDataInformation = "label_empty_data_info"
        
        static let cocktailCell = "cell_cocktail_"
        static let cocktailCellTitle = "cell_cocktail_lbl_title_"
        static let cocktailCellDescription = "cell_cocktail_lbl_description_"
        static let cocktailCellFavoriteImage = "cell_cocktail_img_favorite_"
        
        static let detailNavigationFavoriteButton = "nav_button_detail_favorite"
        static let detailNavigationBackButton = "nav_button_detail_back"
        
        static let detailCell = "cell_detail_"
        static let detailCellText = "cell_detail_text_"
        static let detailCellIcon = "cell_detail_icon_"
        static let detailCellBanner = "cell_detail_img_"
        
        static let cocktailErrorOk = "alert_error_cocktail_ok"
        static let cocktailErrorRetry = "alert_error_cocktail_retry"
    }
}

enum CocktailFilterOption: String, CaseIterable {
    case all = "All"
    case alcoholic = "Alcoholic"
    case nonAlcoholic = "Non-Alcoholic"
    
    init(item: Int) {
        switch item {
        case 0: self = .all
        case 1: self = .alcoholic
        case 2: self = .nonAlcoholic
        default: self = .all
        }
    }
    
    func index() -> Int {
        switch self {
        case .all: return 0
        case .alcoholic: return 1
        case .nonAlcoholic: return 2
        }
    }
}

enum CocktailError: String, Error, CustomStringConvertible {
    case none = ""
    case jsonParsing = "JSON Parsing failed"
    case networkFailure = "Network failure"
    
    var description: String {
        self.rawValue
    }
    
    func code() -> Int {
        switch self {
        case .none: return 0
        case .jsonParsing: return 100
        case .networkFailure: return 101
        }
    }
}
