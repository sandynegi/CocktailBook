//
//  HomeViewController+Delegate.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 31/08/24.
//

import Foundation
import UIKit

// MARK: DetailViewControllerDelegate
extension HomeViewController: DetailViewControllerDelegate {
    func cocktailAddToFavorite(cocktail: CocktailUIModel) {
        debugPrint(#function)
        cocktailViewModel?.addToFavorite(id: cocktail.id ?? .empty)
        tvCocktailList?.reloadData()
    }
    
    func cocktailRemoveFromFavorite(cocktail: CocktailUIModel) {
        debugPrint(#function)
        cocktailViewModel?.removeFromFavorite(id: cocktail.id ?? .empty)
        tvCocktailList?.reloadData()
    }
}

// MARK: Error Alert View
extension HomeViewController {
    func showErrorAlert(description: String) {
        let errorAlert = UIAlertController(title: "Error",
                                           message: description,
                                           preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default ,
                                     handler:{ _ in
            debugPrint("Option Selected: Ok")
        })
        okAction.accessibilityIdentifier = AppConstants.Accessibility.cocktailErrorOk
        errorAlert.addAction(okAction)
        
        
        let retryAction = UIAlertAction(title: "Retry",
                                        style: .default ,
                                        handler:{ [weak self] _ in
            debugPrint("Option Selected: Retry")
            self?.fetchCocktails()
        })
        retryAction.accessibilityIdentifier = AppConstants.Accessibility.cocktailErrorRetry
        errorAlert.addAction(retryAction)
        
        self.present(errorAlert,
                     animated: true,
                     completion: {
            debugPrint("Error Alert view presented")
        })
    }
}
