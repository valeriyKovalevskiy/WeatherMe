//
//  DetailViewController.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import UIKit
//TODO: - Is it good idea to initialize controller already with dataModel?

final class DetailViewController: BaseViewController {
    //MARK: - Layout
    fileprivate let temperatureLabel: UILabel = {
        let label = UILabel()
        let mainColor = UIColor(named: "textColor")!
        label.textColor = mainColor
        label.textAlignment = .center
        label.font = UIFont(name: "SFUIText-Semibold", size: 45)
        label.numberOfLines = 0
        
        return label
    }()
    
    fileprivate let descriptionLabel: UILabel = {
        let label = UILabel()
        let mainColor = UIColor(named: "textColor")!
        label.textColor = mainColor
        label.textAlignment = .center
        label.font = UIFont(name: "SFUIText-Semibold", size: 28)
        label.numberOfLines = 0

        return label
    }()

    //MARK: - Properties
    var model: City?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupNavigationBar()
        setupTitle()
        setupTemperatureLabel()
        setupDescriptionLabelLabel()
    }
    
    override func viewWillLayoutSubviews() {
        temperatureLabel.frame = CGRect(x: view.center.x - view.width / 3,
                                        y: view.top + 200,
                                        width: view.width / 1.5,
                                        height: 50)
        descriptionLabel.frame = CGRect(x: view.center.x - view.width / 3,
                                        y: temperatureLabel.bottom + 20,
                                        width: view.width / 1.5,
                                        height: 50)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //save to core data latest weather response
    }

    //MARK: - Fileprivate methods
    fileprivate func setupTitle() {
        title = model?.name
        
    }
    
    fileprivate func setupTemperatureLabel() {
        view.addSubview(temperatureLabel)

        if let model = model {
            temperatureLabel.text = String(format: "%.2f", Double(model.mainParameters.temperature - 273.15)) + " °C"
        }
    }
    
    fileprivate func setupDescriptionLabelLabel() {
        view.addSubview(descriptionLabel)

        if let model = model {
            descriptionLabel.text =  "\(model.weather.first?.weatherCondition ?? "")"
        }
    }
    
    
}
