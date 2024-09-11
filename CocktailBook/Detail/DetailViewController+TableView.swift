//
//  DetailViewController+TableView.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 30/08/24.
//

import Foundation
import UIKit

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (uiViewModel?.rows.isEmpty ?? true) ? .zero : .one
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uiViewModel?.rows.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = uiViewModel?.rows[indexPath.row]
        if (row?.type ?? .none) == .banner {
            return view.frame.width * (9.0/16.0)
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cocktailDetailCell: UITableViewCell?
        
        let row = uiViewModel?.rows[indexPath.row]
        
        switch row?.type ?? .none {
        case .none: break
        case .iconText, .text, .header:
            let iconTextCell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableViewCellIdentifier.detailIconText,
                                                               for: indexPath) as? DetailIconTextTableViewCell
            
            iconTextCell?.setup(row: row, rowIndex: indexPath.row)
            cocktailDetailCell = iconTextCell
        case .banner:
            let bannerCell = tableView.dequeueReusableCell(withIdentifier: AppConstants.TableViewCellIdentifier.detailBanner,
                                                               for: indexPath) as? DetailBannerTableViewCell
            bannerCell?.setup(imgName: row?.icon ?? .empty, rowIndex: indexPath.row)
            cocktailDetailCell = bannerCell
        }
        
        cocktailDetailCell?.accessibilityIdentifier = AppConstants.Accessibility.detailCell + "\(indexPath.row)"
        return cocktailDetailCell ?? UITableViewCell(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint(#function)
    }
}
