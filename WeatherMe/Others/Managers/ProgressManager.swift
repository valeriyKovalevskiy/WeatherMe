//
//  ProgressManager.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/18/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation
import SVProgressHUD

class ProgressManager {
    static let shared = ProgressManager()
    
    func showLoader(with status: String? = nil) {
        SVProgressHUD.setFont(UIFont(name: "SFUIText-Light", size: 23)!)
        SVProgressHUD.show(withStatus: status)
    }
    
    func dismissLoader(completion: SVProgressHUDDismissCompletion? = nil) {
        SVProgressHUD.dismiss(completion: completion)
    }
    
    func dismissWithError(_ error: String) {
        SVProgressHUD.setFont(UIFont(name: "SFUIText-Light", size: 23)!)
        SVProgressHUD.showError(withStatus: error)
    }
}
