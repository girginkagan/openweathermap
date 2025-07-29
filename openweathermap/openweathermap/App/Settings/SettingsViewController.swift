//
//  SettingsViewController.swift
//  openweathermap
//
//  Created by Kagan Girgin on 29/07/2025.
//

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: Properties
    private var viewModel: SettingsViewModel?
    
    // MARK: UI Components
    private lazy var lblTemperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "Temperature"
        return label
    }()
    
    private lazy var stackViewSwitchContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 6
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private lazy var viewCelcius: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let isMetric = DataProvider.sharedInstance.selectedUnit == "metric"
        view.backgroundColor = isMetric ? Colors.colorSelected.color : Colors.mainBackground.color
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(didTapViewCelcius)
            )
        )
        return view
    }()
    
    private lazy var viewFahrenheit: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let isImperial = DataProvider.sharedInstance.selectedUnit == "imperial"
        view.backgroundColor = isImperial ? Colors.colorSelected.color : Colors.mainBackground.color
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(didTapViewFahrenheit)
            )
        )
        return view
    }()
    
    private lazy var lblCelcius: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = Colors.white.color
        label.text = "°C"
        return label
    }()
    
    private lazy var lblFahrenheit: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = Colors.white.color
        label.text = "°F"
        return label
    }()
    
    private lazy var btnChangeCity: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(Colors.white.color, for: .normal)
        button.setTitle("CHANGE CITY", for: .normal)
        button.backgroundColor = Colors.mainBackground.color
        button.layer.cornerRadius = 8
        button.addTarget(
            self,
            action: #selector(didTapChangeCityButton),
            for: .touchUpInside
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        view.backgroundColor = Colors.white.color
        
        let rightBarButtonItem = UIBarButtonItem(
            image: Images.icClose.image,
            style: .done,
            target: self,
            action: #selector(didTapRightBarButton)
        )
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.title = "Settings"
        
        view.addSubview(lblTemperature)
        view.addSubview(stackViewSwitchContainer)
        stackViewSwitchContainer.addArrangedSubview(viewCelcius)
        stackViewSwitchContainer.addArrangedSubview(viewFahrenheit)
        viewCelcius.addSubview(lblCelcius)
        viewFahrenheit.addSubview(lblFahrenheit)
        view.addSubview(btnChangeCity)
        
        NSLayoutConstraint.activate([
            lblTemperature.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblTemperature.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            
            stackViewSwitchContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackViewSwitchContainer.centerYAnchor.constraint(equalTo: lblTemperature.centerYAnchor),
            stackViewSwitchContainer.heightAnchor.constraint(equalToConstant: 30),
            stackViewSwitchContainer.widthAnchor.constraint(equalToConstant: 100),
            
            lblCelcius.centerYAnchor.constraint(equalTo: viewCelcius.centerYAnchor),
            lblCelcius.centerXAnchor.constraint(equalTo: viewCelcius.centerXAnchor),
            
            lblFahrenheit.centerYAnchor.constraint(equalTo: viewFahrenheit.centerYAnchor),
            lblFahrenheit.centerXAnchor.constraint(equalTo: viewFahrenheit.centerXAnchor),
            
            btnChangeCity.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            btnChangeCity.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            btnChangeCity.heightAnchor.constraint(equalToConstant: 45),
            btnChangeCity.topAnchor.constraint(equalTo: stackViewSwitchContainer.bottomAnchor, constant: 28)
        ])
    }
    
    @objc private func didTapRightBarButton() {
        dismiss(animated: true)
    }
    
    @objc private func didTapViewCelcius() {
        viewCelcius.backgroundColor = Colors.colorSelected.color
        viewFahrenheit.backgroundColor = Colors.mainBackground.color
        
        DataProvider.sharedInstance.selectedUnit = "metric"
    }
    
    @objc private func didTapViewFahrenheit() {
        viewFahrenheit.backgroundColor = Colors.colorSelected.color
        viewCelcius.backgroundColor = Colors.mainBackground.color
        
        DataProvider.sharedInstance.selectedUnit = "imperial"
    }
    
    @objc private func didTapChangeCityButton() {
        let viewController = SelectCityViewController(
            viewModel: SelectCityViewModel()
        )
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
    }
}
