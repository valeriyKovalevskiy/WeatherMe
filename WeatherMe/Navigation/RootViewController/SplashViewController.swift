//
//  SplashViewController.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import UIKit

//TODO: - Create all server requests
//TODO: - Navigate after requests, while requests run show loader

class SplashViewController: UIViewController {
    static let instance = SplashViewController()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            AppDelegate.shared.rootViewController.showFirstScreen()
        }
    }

    //MARK: - Private Methods
    private func createNetworkingRequests() {

    }
    
    private func setInitialController() {

    }
    
}
