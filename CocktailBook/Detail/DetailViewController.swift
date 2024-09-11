//
//  DetailViewController.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 28/08/24.
//

import Foundation
import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func cocktailAddToFavorite(cocktail: CocktailUIModel)
    func cocktailRemoveFromFavorite(cocktail: CocktailUIModel)
}

class DetailViewController: UIViewController {
    
    var cocktailType: CocktailFilterOption = .all
    var cocktail: CocktailUIModel?
    
    weak var delegate: DetailViewControllerDelegate?
    
    var uiViewModel: DetailUIViewModel?
    
    @IBOutlet weak var tvCocktailDetail: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = cocktail?.name ?? .empty
        
        setupFavoriteBarButton(isFavorite: cocktail?.isFavorite ?? false)
        
        setupBackBarButton(title: cocktailType.rawValue)
    }
    
    func setupBackBarButton(title: String) {
        let btnBack = UIButton(type: .custom)
        
        btnBack.setImage(UIImage(systemName: AppConstants.ImageName.chevronBackward), for: .normal)
        
        btnBack.setTitle(title, for: .normal)
        btnBack.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        btnBack.setTitleColor(.accentColor, for: .normal)
        
        btnBack.addTarget(self,
                              action: #selector(backButtonPressed),
                              for: .touchUpInside)
        
        btnBack.frame = CGRectMake(.zero, .zero, .zero, .thirty)
        
        btnBack.accessibilityIdentifier = AppConstants.Accessibility.detailNavigationBackButton
        
        let bbtnBack = UIBarButtonItem(customView: btnBack)
        
        navigationItem.leftBarButtonItem = bbtnBack
    }
    
    func setupFavoriteBarButton(isFavorite: Bool) {
        let btnFavorite = UIButton(type: .custom)
        
        
        let favoriteIconName = isFavorite ? AppConstants.ImageName.heartFill : AppConstants.ImageName.heartEmpty
        
        btnFavorite.setImage(UIImage(systemName: favoriteIconName),
                             for: .normal)
        
        btnFavorite.addTarget(self,
                              action: #selector(addToFavoritePressed),
                              for: .touchUpInside)
        
        btnFavorite.frame = CGRectMake(.zero, .zero, .thirty, .thirty)
        
        btnFavorite.accessibilityIdentifier = AppConstants.Accessibility.detailNavigationFavoriteButton
        
        let bbtnFavorite = UIBarButtonItem(customView: btnFavorite)
        
        navigationItem.rightBarButtonItem = bbtnFavorite
    }
    
    private func initialSetup() {
        tvCocktailDetail?.accessibilityIdentifier = AppConstants.Accessibility.tvDetailTable
        
        tvCocktailDetail?.register(UINib(nibName: AppConstants.TableViewCellIdentifier.detailIconText, bundle: nil),
                                 forCellReuseIdentifier: AppConstants.TableViewCellIdentifier.detailIconText)
        
        tvCocktailDetail?.register(UINib(nibName: AppConstants.TableViewCellIdentifier.detailBanner, bundle: nil),
                                 forCellReuseIdentifier: AppConstants.TableViewCellIdentifier.detailBanner)

        
        if uiViewModel == nil {
            uiViewModel = DetailUIViewModel()
        }
        
        setupRowData()
        
        updateUI()
    }
    
    private func updateUI() {
        tvCocktailDetail?.dataSource = self
        tvCocktailDetail?.delegate = self
        
        tvCocktailDetail?.reloadData()
    }
    
    private func setupRowData() {
        
        let timerRow = DetailScreenDisplayRow(icon: AppConstants.ImageName.clock,
                                              text: "\(cocktail?.preparationMinutes ?? .zero) minutes",
                                              type: .iconText)
        uiViewModel?.rows.append(timerRow)
        
        let bannerRow = DetailScreenDisplayRow(icon: cocktail?.imageName ?? .empty,
                                               text: .empty,
                                               type: .banner)
        uiViewModel?.rows.append(bannerRow)
        
        let descriptionRow = DetailScreenDisplayRow(icon: .empty,
                                                    text: cocktail?.longDescription ?? .empty,
                                                    type: .text)
        uiViewModel?.rows.append(descriptionRow)
        
        let ingredentTitleRow = DetailScreenDisplayRow(icon: .empty,
                                                    text: "Ingredients",
                                                    type: .header)
        uiViewModel?.rows.append(ingredentTitleRow)
        
        
        for item in cocktail?.ingredients ?? [] {
            let ingredentRow = DetailScreenDisplayRow(icon: AppConstants.ImageName.rightArrowFilled,
                                                      text: item,
                                                      type: .iconText)
            uiViewModel?.rows.append(ingredentRow)
        }
    }
    
    @objc
    func addToFavoritePressed(_ sender: UIButton) {
        if let cocktail {
            if cocktail.isFavorite {
                delegate?.cocktailRemoveFromFavorite(cocktail: cocktail)
            } else {
                delegate?.cocktailAddToFavorite(cocktail: cocktail)
            }
            self.cocktail?.isFavorite = !cocktail.isFavorite
            setupFavoriteBarButton(isFavorite: !cocktail.isFavorite)
        }
    }
    
    @objc
    func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

