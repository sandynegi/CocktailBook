//
//  DetailIconTextTableViewCell.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 30/08/24.
//

import UIKit

class DetailIconTextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblText: UILabel?
    @IBOutlet weak var imgIcon: UIImageView?
    
    @IBOutlet weak var widthConstraintOfIcon: NSLayoutConstraint?
    @IBOutlet weak var trailingConstraintOfIcon: NSLayoutConstraint?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(row: DetailScreenDisplayRow?, rowIndex: Int) {
        widthConstraintOfIcon?.constant = .zero
        trailingConstraintOfIcon?.constant = .zero
        lblText?.textAlignment = .natural
        lblText?.textColor = .titleColor
        lblText?.font = UIFont.systemFont(ofSize: .fourteen, weight: .regular)
        
        lblText?.text = row?.text
        
        if let icon = row?.icon {
            imgIcon?.image = UIImage(systemName: icon)
        } else {
            imgIcon?.image = nil
        }
        imgIcon?.tintColor = .titleColor
        
        switch row?.type ?? .none {
        case .iconText:
            widthConstraintOfIcon?.constant = .twenty
            trailingConstraintOfIcon?.constant = .ten
            
        case .text:
            lblText?.textAlignment = .justified
            lblText?.textColor = .contentColor
            lblText?.font = UIFont.systemFont(ofSize: .sixteen, weight: .regular)
            
        case .header:
            lblText?.font = UIFont.systemFont(ofSize: .sixteen, weight: .bold)
            
        default: break
        }
        
        lblText?.accessibilityIdentifier = AppConstants.Accessibility.detailCellText + "\(rowIndex)"
        imgIcon?.accessibilityIdentifier = AppConstants.Accessibility.detailCellIcon + "\(rowIndex)"
    }
}
