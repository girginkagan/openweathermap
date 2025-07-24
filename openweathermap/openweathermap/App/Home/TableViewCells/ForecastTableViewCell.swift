//
//  ForecastTableViewCell.swift
//  openweathermap
//
//  Created by Kagan Girgin on 24/07/2025.
//

import UIKit

final class ForecastTableViewCell: UITableViewCell {
    // MARK: UI Components
    private lazy var stackViewData: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var lblSky: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private lazy var lblDegree: UILabel = {
        let lblTitle = UILabel()
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.font = .systemFont(ofSize: 14, weight: .regular)
        lblTitle.textColor = .black
        return lblTitle
    }()
    
    private lazy var lblDate: UILabel = {
        let lblTitle = UILabel()
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.font = .systemFont(ofSize: 14, weight: .regular)
        lblTitle.textColor = .black
        return lblTitle
    }()
    
    private lazy var ivItem: UIImageView = {
        let ivItem = UIImageView()
        ivItem.translatesAutoresizingMaskIntoConstraints = false
        return ivItem
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        backgroundColor = Colors.white.color
        contentView.addSubview(ivItem)
        stackViewData.addArrangedSubview(lblSky)
        stackViewData.addArrangedSubview(lblDegree)
        contentView.addSubview(stackViewData)
        contentView.addSubview(lblDate)
        
        //MARK: Constraints
        NSLayoutConstraint.activate([
            ivItem.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ivItem.widthAnchor.constraint(equalToConstant: 45),
            ivItem.heightAnchor.constraint(equalToConstant: 45),
            ivItem.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackViewData.leadingAnchor.constraint(equalTo: ivItem.trailingAnchor, constant: 8),
            stackViewData.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lblDate.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lblDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func updateCell(data: List) {
        ivItem.kf.setImage(
            with: URL(
                string: "https://openweathermap.org/img/wn/" + (data.weather?.first?.icon ?? "") + "@2x.png"
            )
        )
        let isMetric = DataProvider.sharedInstance.selectedUnit == "metric"
        lblDegree.text = String(Int(data.main?.temp ?? 0)) + (isMetric ? "°C" : "°F")
        lblSky.text = data.weather?.first?.main
        lblDate.text = data.dtTxt?.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")?.toString(dateFormat: "yyyy-MM-dd")
    }
}
