//
//  SearchViewController.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

//TODO: - Should we remove navigation methods from controller class? ( View, according MVVM pattern )

import UIKit

final class SearchViewController: BaseViewController {
    //MARK: - Layout
    fileprivate let searchButton: UIButton = {
        let button = UIButton()
        let mainColor = UIColor(named: "textColor")!
        let backgrountColor = UIColor.clear
        button.backgroundColor = backgrountColor
        button.setTitleColor(mainColor, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFUIText-Light", size: 23)
        
        return button
    }()

    fileprivate let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        let searchTextField = searchBar.searchTextField
        let image: UIImage = UIImage(systemName: "magnifyingglass")!
        let mainColor = UIColor(named: "textColor")!
        let backgrountColor = UIColor.clear
        searchBar.layer.masksToBounds = true
        searchBar.tintColor = mainColor
        searchBar.layer.cornerRadius = 12
        searchBar.layer.borderWidth = 1
        searchBar.backgroundColor = backgrountColor
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchTextField.placeholder = "City ..."
        searchTextField.backgroundColor = backgrountColor
        searchTextField.textColor = mainColor
        searchTextField.textAlignment = .left
        searchTextField.font = UIFont(name: "SFUIText-Light", size: 23)
        DispatchQueue.main.async {
            searchBar.changePlaceholderColor(mainColor)
            searchBar.setupRightView(with: image, tintColor: mainColor)
        }

        return searchBar
    }()
    
    fileprivate let logoImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "logo")!
        let mainColor = UIColor(named: "textColor")!
        imageView.image = image
        imageView.tintColor = mainColor

        return imageView
    }()
    
    //MARK: - Constants
    fileprivate let viewModel = SearchViewControllerViewModel()
    fileprivate let progress = ProgressManager.shared
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLogo()
        setupSearchBar()
        setupSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchButton.layer.borderColor = UIColor(named: "textColor")?.cgColor
        searchBar.layer.borderColor = UIColor(named: "textColor")?.cgColor
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillLayoutSubviews() {

        
        logoImageView.frame = CGRect(x: view.center.x - view.width * 0.25,
                                     y: view.center.y - view.width * 0.5 - 20,
                                     width: view.width * 0.5,
                                     height: view.width * 0.5)
        
        searchBar.frame = CGRect(x: view.center.x - view.width * 0.4,
                                 y: view.center.y,
                                 width: view.width * 0.8,
                                 height: 44)
        
        searchButton.frame = CGRect(x: view.center.x - searchBar.width / 4,
                                    y: searchBar.bottom + 20,
                                    width: searchBar.width / 2,
                                    height: 44)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
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

    
    
    fileprivate func setupSearchButton() {
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(didTappedSearchButton), for: .touchUpInside)
    }
    
    fileprivate func setupLogo() {
        view.addSubview(logoImageView)
    }
    
    fileprivate func setupSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    
}

//MARK: - Keyboard handling methods
extension SearchViewController: UISearchBarDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        didTappedSearchButton()
    }
}
