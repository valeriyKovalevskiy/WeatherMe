//
//  BaseViewController.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/19/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    //MARK: - Constants
    fileprivate let navigationBarFont = UIFont(name: "SFUIText-Light", size: 23)!
    fileprivate let textColor = UIColor(named: "textColor")!
    fileprivate let topGradientColor = UIColor(named: "topGradientColor")!
    fileprivate let bottomGradientColor = UIColor(named: "bottomGradientColor")!

    //MARK: - Public methods
    func setupView() {
        let gradientView = UIView(frame: UIScreen.main.bounds)
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientView.layer.addSublayer(gradientLayer)
        
        self.view = gradientView
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(didTappedBackButton))
        navigationController?.navigationBar.tintColor = textColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        UINavigationBar.appearance().isTranslucent = true
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: navigationBarFont], for: .normal)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : textColor,
                                                            NSAttributedString.Key.font: navigationBarFont]
    }

    //MARK: - Fileprivate methods
    @objc fileprivate func didTappedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
