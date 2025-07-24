//
//  HomeViewController.swift
//  openweathermap
//
//  Created by Kagan Girgin on 22/07/2025.
//

import Kingfisher
import UIKit

final class HomeViewController: UIViewController {
    // MARK: Properties
    private var viewModel: HomeViewModel?
    private var tableViewSource: HomeTableViewSource?
    
    // MARK: UI Components
    private lazy var viewTop: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.blue.color
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var viewTopContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ivItem: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var lblDegree: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .heavy)
        label.textColor = Colors.white.color
        return label
    }()
    
    private lazy var lblCity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = Colors.white.color
        return label
    }()
    
    private lazy var lblSky: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = Colors.white.color
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(
            top: 200,
            left: 0,
            bottom: 0,
            right: 0
        )
        tableView.register(
            DayForecastTableViewCell.self,
            forCellReuseIdentifier: DayForecastTableViewCell.description()
        )
        tableView.register(
            ForecastTableViewCell.self,
            forCellReuseIdentifier: ForecastTableViewCell.description()
        )
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        getData()
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        view.backgroundColor = Colors.white.color
        
        let rightBarButtonItem = UIBarButtonItem(
            image: Images.icSettings.image,
            style: .done,
            target: self,
            action: #selector(
                didTapRightBarButton
            )
        )
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        view.addSubview(viewTop)
        viewTopContainer.addSubview(ivItem)
        viewTopContainer.addSubview(lblDegree)
        viewTopContainer.addSubview(lblCity)
        viewTopContainer.addSubview(lblSky)
        viewTop.addSubview(viewTopContainer)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            viewTop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewTop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewTop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewTop.heightAnchor.constraint(equalToConstant: 200),
            viewTopContainer.centerXAnchor.constraint(equalTo: viewTop.centerXAnchor, constant: -30),
            viewTopContainer.bottomAnchor.constraint(equalTo: viewTop.bottomAnchor, constant: 90),
            ivItem.leadingAnchor.constraint(equalTo: viewTopContainer.leadingAnchor),
            ivItem.widthAnchor.constraint(equalToConstant: 200),
            ivItem.heightAnchor.constraint(equalToConstant: 200),
            lblDegree.topAnchor.constraint(equalTo: viewTopContainer.topAnchor),
            lblDegree.leadingAnchor.constraint(equalTo: ivItem.trailingAnchor, constant: -75),
            ivItem.topAnchor.constraint(equalTo: lblDegree.bottomAnchor, constant: -50),
            ivItem.bottomAnchor.constraint(equalTo: viewTopContainer.bottomAnchor),
            lblCity.topAnchor.constraint(equalTo: lblDegree.bottomAnchor, constant: 10),
            lblCity.leadingAnchor.constraint(equalTo: ivItem.trailingAnchor, constant: -40),
            lblSky.leadingAnchor.constraint(equalTo: ivItem.trailingAnchor, constant: -40),
            lblSky.topAnchor.constraint(equalTo: lblCity.bottomAnchor, constant: 4),
            lblCity.trailingAnchor.constraint(equalTo: viewTopContainer.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func getData() {
        viewModel?.getForecast(
            city: DataProvider.sharedInstance.selectedCity,
            unit: DataProvider.sharedInstance.selectedUnit,
            completion: { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let data):
                    processData(data: data)
                case .failure(_):
                    break
                }
        })
    }
    
    @objc private func didTapRightBarButton() {
        
    }
    
    private func configureTopView(data: List) {
        guard let weather = data.weather?.first else { return }
        ivItem.kf.setImage(
            with: URL(
                string: "https://openweathermap.org/img/wn/" + (weather.icon ?? "") + "@2x.png"
            )
        )
        lblSky.text = weather.main
        let isMetric = DataProvider.sharedInstance.selectedUnit == "metric"
        lblDegree.text = String(Int(data.main?.temp ?? 0)) + (isMetric ? "°C" : "°F")
        lblCity.text = DataProvider.sharedInstance.selectedCity
    }
    
    private func processData(data: WeatherResponseModel) {
        guard let item = data.list?.first else { return }
        var totalList: [[List]] = []
        var firstSection: [List] = []
        var secondSection: [List] = data.list ?? []
        let date = item.dtTxt?.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")?.toString(dateFormat: "yyyy-MM-dd") ?? ""
        let indexes = data.list?.enumerated().compactMap({ index, element in
            (element.dtTxt?.contains(date) ?? false) ? index : nil
        })
        indexes?.forEach({ index in
            firstSection.append(secondSection[index])
        })
        secondSection.removeAll(
            where: {
                ($0.dtTxt?.contains(date) ?? false) || !($0.dtTxt?.contains("12:00:00") ?? false)
            })
        
        totalList.append(firstSection)
        totalList.append(secondSection)
        
        configureTopView(data: item)
        
        tableViewSource = HomeTableViewSource(data: totalList)
        tableView.dataSource = tableViewSource
        tableView.delegate = tableViewSource
        tableView.reloadData()
    }
}
