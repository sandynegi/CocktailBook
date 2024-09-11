//
//  HomeViewController.swift
//  CocktailBook
//
//  Created by Sandeep Negi on 28/08/24.
//

import Foundation
import UIKit
import CocktailBookAPIFramework

class HomeViewController: UIViewController {
    
    // MARK: UI elements property
    @IBOutlet weak var scCocktailOptionType: UISegmentedControl?
    @IBOutlet weak var tvCocktailList: UITableView?
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView?
    @IBOutlet weak var lblEmptyDataInformation: UILabel?
    
    // MARK: Data property
    var cocktailViewModel: CocktailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        
        fetchCocktails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateNavigationTitle(title: cocktailViewModel?.selectedCocktailFilter.rawValue
                              ?? CocktailFilterOption.all.rawValue)
    }
    
    func updateNavigationTitle(title: String) {
        //Setup in base class
        self.navigationItem.title = "\(title) Cocktails"
    }
    
    func loadDetailScreen(with cocktail: CocktailUIModel) {
        let detailViewController: DetailViewController? = UIStoryboard.screenController(storyboardId: AppConstants.StoryboardId.detail)
        detailViewController?.delegate = self
        detailViewController?.cocktail = cocktail
        detailViewController?.cocktailType = CocktailFilterOption(item: scCocktailOptionType?.selectedSegmentIndex ?? .zero)
        if let detailViewController {
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func initialSetup() {
        scCocktailOptionType?.accessibilityIdentifier = AppConstants.Accessibility.scCocktailOptions
        
        for item in CocktailFilterOption.allCases {
            scCocktailOptionType?.setTitle(item.rawValue, forSegmentAt: item.index())
        }
        
        tvCocktailList?.isHidden = true
        tvCocktailList?.accessibilityIdentifier = AppConstants.Accessibility.tvCocktailTable
        tvCocktailList?.register(UINib(nibName: AppConstants.TableViewCellIdentifier.cocktailItem, bundle: nil),
                                 forCellReuseIdentifier: AppConstants.TableViewCellIdentifier.cocktailItem)
        
        lblEmptyDataInformation?.isHidden = true
        lblEmptyDataInformation?.textColor = .contentColor
        lblEmptyDataInformation?.accessibilityIdentifier = AppConstants.Accessibility.lblEmptyDataInformation
    }
    
    func updateCocktailListUI() {
        lblEmptyDataInformation?.isHidden = true
        tvCocktailList?.isHidden = false
        tvCocktailList?.dataSource = self
        tvCocktailList?.delegate = self
        
        tvCocktailList?.reloadData()
    }
    
    func showEmptyDataView() {
        tvCocktailList?.isHidden = true
        lblEmptyDataInformation?.isHidden = false
    }
    
    func fetchCocktails() {
        if cocktailViewModel == nil {
            cocktailViewModel = CocktailViewModel(apiCaller: FakeCocktailsAPI())
        }
        tvCocktailList?.isHidden = true
        lblEmptyDataInformation?.isHidden = true
        progressIndicator?.startAnimating()
        cocktailViewModel?.fetch(completionHandler: { status, error in
            if status {
                DispatchQueue.main.async { [weak self] in
                    self?.updateCocktailListUI()
                    self?.progressIndicator?.stopAnimating()
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.progressIndicator?.stopAnimating()
                    self?.showEmptyDataView()
                    self?.showErrorAlert(description: error?.description ?? .empty)
                }
            }
        })
    }
    
    @IBAction func cocktailOptionTypeDidChanged(_ sender: UISegmentedControl) {
        let selectionOption = CocktailFilterOption(item: sender.selectedSegmentIndex)
        updateNavigationTitle(title: selectionOption.rawValue)
        cocktailViewModel?.selectedCocktailFilter = selectionOption
        tvCocktailList?.reloadData()
    }
}
