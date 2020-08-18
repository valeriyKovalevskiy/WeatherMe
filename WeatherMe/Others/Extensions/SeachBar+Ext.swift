//
//  SeachBar+Ext.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import UIKit

extension UISearchBar {
    public var textField: UITextField? {
        if #available(iOS 13, *) {
            return searchTextField
        }
        
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField}).first as? UITextField else { return nil }
        
        return textField
    }
    
    func setupRightView(with image: UIImage) {
        let imageView: UIImageView = UIImageView.init(image: image)
        let searchTextField = self.searchTextField
        imageView.tintColor = .brown
        searchTextField.leftView = nil
        searchTextField.rightView = imageView
        searchTextField.rightViewMode = .unlessEditing
    }
    
    func changePlaceholderColor(_ color: UIColor) {
        guard let UISearchBarTextFieldLabel: AnyClass = NSClassFromString("UISearchBarTextFieldLabel"),
            let field = textField else { return }
        
        for subview in field.subviews where subview.isKind(of: UISearchBarTextFieldLabel) {
            (subview as! UILabel).textColor = color
        }
    }
    

}
