//
//  SearchViewController.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

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

        searchBar.layer.masksToBounds = true
        searchBar.layer.borderWidth = 2.0
        searchBar.layer.borderColor = UIColor.brown.cgColor
        searchBar.layer.cornerRadius = 12
        DispatchQueue.main.async {
            let image: UIImage = UIImage(systemName: "magnifyingglass")!
            let imageView: UIImageView = UIImageView.init(image: image)
            
            imageView.tintColor = .brown
            searchTextField.leftView = nil
            searchTextField.rightView = imageView
            searchTextField.rightViewMode = .unlessEditing
            searchBar.changePlaceholderColor(.brown)
        }
        
        searchTextField.placeholder = "Search ..."
        searchTextField.textColor = UIColor.brown
        searchTextField.textAlignment = .left
        searchTextField.font = .systemFont(ofSize: 15, weight: .semibold)
        
        return searchBar
    }()

    fileprivate let viewModel = SearchViewControllerViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search city"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(searchBar)
        view.addSubview(searchButton)

        searchButton.addTarget(self, action: #selector(didTappedSearchButton), for: .touchUpInside)

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

    @objc private func didTappedSearchButton() {
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        viewModel.getDocuments(for: text) { [weak self] (result) in
            guard let strongSelf = self else { return }
            
            let controller = DetailViewController()
            controller.model = result
            strongSelf.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    
    
    
    
    
}
