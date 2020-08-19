//
//  RootViewController.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import UIKit

//TODO: - Make animateFadeTransition custom transitions
//TODO: - Create fonts sizes style ( 23 28 45 )

class RootViewController: UIViewController {
    //MARK: - Properties
    fileprivate var currentViewController: UIViewController = SplashViewController.instance
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        addChild(currentViewController)
        currentViewController.view.frame = view.bounds
        view.addSubview(currentViewController.view)
        currentViewController.didMove(toParent: self)
    }

    
    //MARK: - Internal Methods
    func showFirstScreen() {
        let controller = UINavigationController(rootViewController: SearchViewController())
        animateFadeTransition(to: controller)
    }
    
//    func showLoginScreen() {
//        let controller = UINavigationController(rootViewController: SecondViewController())
//        animateFadeTransition(to: controller)
//    }
//
//    func showMainScreen() {
//        let controller = UINavigationController(rootViewController: ThirdViewController())
//        animateFadeTransition(to: controller)
//    }
    
    //MARK: - Private Methods
    private func animateFadeTransition(to newViewController: UIViewController, completion: (() -> Void)? = nil) {
        currentViewController.willMove(toParent: nil)
        addChild(newViewController)
        
        transition(from: currentViewController,
                   to: newViewController,
                   duration: 0.3,
                   options: [.transitionCrossDissolve, .curveEaseOut],
                   animations: nil) { [weak self] completed in
                    
            self?.currentViewController.removeFromParent()
            newViewController.didMove(toParent: self)
            self?.currentViewController = newViewController
            completion?()
        }
    }

}


