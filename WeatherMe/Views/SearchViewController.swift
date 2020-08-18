//
//  SearchViewController.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

//TODO: - Should we remove navigation methods from controller class? ( View, according MVVM pattern )
//TODO: - Create manager for progress hud

import UIKit

final class SearchViewController: UIViewController {
    //MARK: - Layout
    fileprivate let searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setTitleColor(.brown, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.setTitle("Send request", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)
        
        return button
    }()

    fileprivate let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        let searchTextField = searchBar.searchTextField
        let image: UIImage = UIImage(systemName: "magnifyingglass")!
        searchBar.layer.masksToBounds = true
        searchBar.layer.borderWidth = 2.0
        searchBar.layer.borderColor = UIColor.brown.cgColor
        searchBar.layer.cornerRadius = 12
        searchTextField.placeholder = "Search"
        searchTextField.textColor = UIColor.brown
        searchTextField.textAlignment = .left
        searchTextField.font = .systemFont(ofSize: 15, weight: .medium)
        DispatchQueue.main.async {
            searchBar.changePlaceholderColor(.brown)
            searchBar.setupRightView(with: image)
        }
        
        return searchBar
    }()
    
    //MARK: - Constants
    fileprivate let viewModel = SearchViewControllerViewModel()
    fileprivate let progress = ProgressManager.shared
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupTitle()
        setupSearchBar()
        setupSearchButton()
    }
    
    override func viewWillLayoutSubviews() {
        searchBar.frame = CGRect(x: view.center.x - view.width * 0.4,
                                 y: view.top + 200,
                                 width: view.width * 0.8,
                                 height: 44)
        
        searchButton.frame = CGRect(x: view.center.x - searchBar.width / 2,
                                    y: searchBar.bottom + 20,
                                    width: searchBar.width,
                                    height: 44)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        searchBar.textField?.text = ""
    }

    //MARK: - Actions
    @objc fileprivate func didTappedSearchButton() {
        guard let text = searchBar.text, !text.isEmpty else { return } //custom error alerts?
        progress.showLoader()

        viewModel.getDocuments(for: text) { [weak self] (result) in
            guard let strongSelf = self else { return }
            let controller = DetailViewController()
            controller.model = result
            
            strongSelf.progress.dismissLoader()
            strongSelf.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    //MARK: - Fileprivate methods
    fileprivate func setupTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search city"
    }
    
    fileprivate func setupSearchButton() {
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(didTappedSearchButton), for: .touchUpInside)
    }
    
    fileprivate func setupSearchBar() {
        view.addSubview(searchBar)
    }
    
    
}
