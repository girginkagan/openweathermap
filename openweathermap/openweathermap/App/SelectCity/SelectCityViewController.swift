//
//  Untitled.swift
//  openweathermap
//
//  Created by Kagan Girgin on 17/07/2025.
//

import UIKit

final class SelectCityViewController: UIViewController {
    // MARK: Properties
    private var viewModel: SelectCityViewModel?
    
    // MARK: UI Components
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search city"
        searchBar.barTintColor = Colors.white.color
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            CityTableViewCell.self,
            forCellReuseIdentifier: CityTableViewCell.description()
        )
        return tableView
    }()
    
    var tableViewSource: SelectCityTableViewSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    init(viewModel: SelectCityViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        view.backgroundColor = Colors.white.color
        navigationItem.title = "Choose City"
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SelectCityViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        viewModel?.getCities(
            name: searchBar.text ?? "",
            completion: { [weak self] result in
                guard let self else {
                    return
                }
                switch result {
                case .success(let data):
                    tableViewSource = SelectCityTableViewSource(
                        data: data,
                        delegate: self
                    )
                    tableView.dataSource = tableViewSource
                    tableView.delegate = tableViewSource
                    tableView.reloadData()
                    
            case .failure(_):
                break
            }
        })
    }
}

extension SelectCityViewController: SelectCityTableViewSourceDelegate {
    func didTapCity(data: CitiesResponseModelElement) {
        DataProvider.sharedInstance.selectedCity = data.name ?? ""
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Colors.blue.color
        
        let viewController = HomeViewController(viewModel: HomeViewModel())
        let navigationContoller = UINavigationController(rootViewController: viewController)
        navigationContoller.modalPresentationStyle = .fullScreen
        navigationContoller.navigationBar.standardAppearance = appearance
        navigationContoller.navigationBar.scrollEdgeAppearance = navigationContoller.navigationBar.standardAppearance
        navigationContoller.navigationBar.tintColor = Colors.white.color
        
        present(navigationContoller, animated: true)
    }
}
