//
//  CocktailBookUITestAppConstant.swift
//  CocktailBookUITests
//
//  Created by Sandeep Negi on 31/08/24.
//

import Foundation

enum TestAppConstants {
    enum Accessibility {
        static let scCocktailOptions = "segment_control_cocktail_options"
        static let tvCocktailTable = "table_view_cocktail_list"
        static let tvDetailTable = "table_view_cocktail_detail"
        
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
    
    enum StorageKeys {
        static let favoriteList = "kfavoriteList"
    }
}

func clearFavoriteCache() {
    UserDefaults.standard.removeObject(forKey: TestAppConstants.StorageKeys.favoriteList)
    UserDefaults.standard.synchronize()
}

func favoriteCacheCount() -> Int {
    if let data = UserDefaults.standard.data(forKey: TestAppConstants.StorageKeys.favoriteList) {
        if let decoded = try? JSONDecoder().decode([String].self, from: data) {
            return Set(decoded).count
        }
    }
    return 0
}
