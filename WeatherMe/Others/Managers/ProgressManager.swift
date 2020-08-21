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
        addBlurEffect()
    }
    
    func dismissLoader(completion: SVProgressHUDDismissCompletion? = nil) {
        SVProgressHUD.dismiss { [weak self] in
            completion?()
            self?.removeBlurEffect()
        }
    }
    
    func dismissWithError(_ error: String) {
        SVProgressHUD.setFont(UIFont(name: "SFUIText-Light", size: 23)!)
        SVProgressHUD.showDismissableError(with: error) { [weak self] in
            self?.removeBlurEffect()
        }
    }

    //TODO: - Move to another file
    //MARK: - Visual effect
    fileprivate let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    fileprivate func addBlurEffect() {
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            if let topViewController = window.visibleViewController() {
                blurVisualEffectView.frame = topViewController.view.bounds
                topViewController.view.addSubview(blurVisualEffectView)
            }
        }
    }
    
    fileprivate func removeBlurEffect() {
        blurVisualEffectView.removeFromSuperview()
    }
}

extension SVProgressHUD {
    
    public static func showDismissableError(with status: String, completion: (() -> Void)? = nil) {
        let nc = NotificationCenter.default
        nc.addObserver(
            self, selector: #selector(hudTapped(_:)),
            name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent,
            object: nil
        )
        nc.addObserver(
            self, selector: #selector(hudDisappeared(_:)),
            name: NSNotification.Name.SVProgressHUDWillDisappear,
            object: nil
        )
        SVProgressHUD.showError(withStatus: status)
        SVProgressHUD.setDefaultMaskType(.clear)
        completion?()
    }
    
    @objc
    private static func hudTapped(_ notification: Notification) {
        SVProgressHUD.dismiss()
        SVProgressHUD.setDefaultMaskType(.none)
    }
    
    @objc
    private static func hudDisappeared(_ notification: Notification) {
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent, object: nil)
        nc.removeObserver(self, name: NSNotification.Name.SVProgressHUDWillDisappear, object: nil)
        SVProgressHUD.setDefaultMaskType(.none)
    }
}

