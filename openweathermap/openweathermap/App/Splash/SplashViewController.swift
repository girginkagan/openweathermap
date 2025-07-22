//
//  SplashViewController.swift
//  openweathermap
//
//  Created by Kagan Girgin on 15/07/2025.
//

import UIKit

final class SplashViewController: UIViewController {
    // MARK: Properties
    private var viewModel: SplashViewModel?
    
    // MARK: UI Components
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.icLogo.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = Colors.white.color
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self else { return }
            let viewController = SelectCityViewController(
                viewModel: SelectCityViewModel()
            )
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            
            present(navigationController, animated: true)
        }
    }
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        view.backgroundColor = Colors.mainBackground.color
        
        view.addSubview(activityIndicator)
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            activityIndicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logoImageView.bottomAnchor.constraint(equalTo: activityIndicator.topAnchor, constant: -30),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
