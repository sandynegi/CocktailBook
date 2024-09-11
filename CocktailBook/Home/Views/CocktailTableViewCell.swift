//
//  CocktailTableViewCell.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 29/08/24.
//

import UIKit

class CocktailTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var lblDescription: UILabel?
    @IBOutlet weak var imgFavorite: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setup(cocktail: CocktailUIModel?, rowIndex: Int) {
        lblTitle?.text = cocktail?.name ?? .empty
        lblDescription?.text = cocktail?.shortDescription ?? .empty
        lblDescription?.textColor = .contentColor
        if cocktail?.isFavorite ?? false {
            imgFavorite?.isHidden = false
            imgFavorite?.image = UIImage(systemName: AppConstants.ImageName.heartFill)
            imgFavorite?.tintColor = .accentColor
            lblTitle?.textColor = .accentColor
        } else {
            imgFavorite?.isHidden = false
            imgFavorite?.image = UIImage(systemName: AppConstants.ImageName.heartFill)
            imgFavorite?.tintColor = .clear
            lblTitle?.textColor = .titleColor
        }
        
        lblTitle?.accessibilityIdentifier = AppConstants.Accessibility.cocktailCellTitle + "\(rowIndex)"
        lblDescription?.accessibilityIdentifier = AppConstants.Accessibility.cocktailCellDescription + "\(rowIndex)"
        imgFavorite?.accessibilityIdentifier = AppConstants.Accessibility.cocktailCellFavoriteImage + "\(rowIndex)"
    }
}
