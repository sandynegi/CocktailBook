//
//  HomeViewController+TableView.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 29/08/24.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (cocktailViewModel?.cocktailList?.isEmpty ?? true) ? .zero : .one
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktailViewModel?.cocktailList?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cocktailCell: CocktailTableViewCell?
        
        let cocktail = cocktailViewModel?.cocktailList?[indexPath.row]
        cocktailCell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableViewCellIdentifier.cocktailItem,
                                                     for: indexPath) as? CocktailTableViewCell
        cocktailCell?.setup(cocktail: cocktail, rowIndex: indexPath.row)
        
        cocktailCell?.accessibilityIdentifier = AppConstants.Accessibility.cocktailCell + "\(indexPath.row)"
        
        return cocktailCell ?? UITableViewCell(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cocktail = cocktailViewModel?.cocktailList?[indexPath.row]
        if let cocktail {
            loadDetailScreen(with: cocktail)
        }
    }
}
