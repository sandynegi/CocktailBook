//
//  DetailBannerTableViewCell.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 30/08/24.
//

import UIKit

class DetailBannerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgBanner: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setup(imgName: String, rowIndex: Int) {
        imgBanner?.image = UIImage(named: imgName)
        imgBanner?.accessibilityIdentifier = AppConstants.Accessibility.detailCellBanner + "\(rowIndex)"
    }
}
