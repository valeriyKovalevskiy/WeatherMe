//
//  DetailViewController.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import UIKit
//TODO: - Is it good idea to initialize controller already with dataModel?

final class DetailViewController: UIViewController {
    //MARK: - Layout
    fileprivate let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    fileprivate let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    //MARK: - Properties
    var model: City?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupTitle()
        setupTemperatureLabel()
        setupDescriptionLabelLabel()
    }
    
    override func viewWillLayoutSubviews() {
        temperatureLabel.frame = CGRect(x: view.center.x - view.width / 6,
                                        y: view.top + 200,
                                        width: view.width / 2,
                                        height: 50)
        descriptionLabel.frame = CGRect(x: view.center.x - view.width / 4,
                                        y: temperatureLabel.bottom + 20,
                                        width: view.width / 2,
                                        height: 50)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //save to core data latest weather response
    }

    //MARK: - Fileprivate methods
    fileprivate func setupTitle() {
        navigationController?.navigationBar.prefersLargeTitles = false
        title = model?.name
    }
    
    fileprivate func setupTemperatureLabel() {
        view.addSubview(temperatureLabel)

        if let model = model {
            temperatureLabel.text = "\((model.mainParameters.temperature) - 273.15)"
        }
    }
    
    fileprivate func setupDescriptionLabelLabel() {
        view.addSubview(descriptionLabel)

        if let model = model {
            descriptionLabel.text =  "\(model.weather.first?.weatherCondition ?? "")"
        }
    }
    
    
}
