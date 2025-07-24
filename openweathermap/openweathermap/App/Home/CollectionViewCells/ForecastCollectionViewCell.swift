//
//  ForecastCollectionViewCell.swift
//  openweathermap
//
//  Created by Kagan Girgin on 24/07/2025.
//

import UIKit

final class ForecastCollectionViewCell: UICollectionViewCell {
    // MARK: UI Components
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var lblTime: UILabel = {
        let lblTitle = UILabel()
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.font = .systemFont(ofSize: 14, weight: .regular)
        lblTitle.textColor = .black
        lblTitle.textAlignment = .center
        return lblTitle
    }()
    
    private lazy var lblDegree: UILabel = {
        let lblTitle = UILabel()
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.font = .systemFont(ofSize: 14, weight: .regular)
        lblTitle.textColor = .black
        lblTitle.textAlignment = .center
        return lblTitle
    }()
    
    private lazy var ivItem: UIImageView = {
        let ivItem = UIImageView()
        ivItem.translatesAutoresizingMaskIntoConstraints = false
        return ivItem
    }()
    
    private lazy var viewDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.colorDivider.color
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        backgroundColor = Colors.white.color
        stackView.addArrangedSubview(lblTime)
        stackView.addArrangedSubview(ivItem)
        stackView.addArrangedSubview(lblDegree)
        contentView.addSubview(stackView)
        contentView.addSubview(viewDivider)
        
        //MARK: Constraints
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ivItem.widthAnchor.constraint(equalToConstant: 32),
            ivItem.heightAnchor.constraint(equalToConstant: 32),
            viewDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewDivider.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            viewDivider.widthAnchor.constraint(equalToConstant: 1),
            viewDivider.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func updateCell(
        time: String,
        image: String,
        degree: String
    ) {
        lblTime.text = time
        ivItem.kf.setImage(with: URL(string: "https://openweathermap.org/img/wn/" + image + "@2x.png"))
        lblDegree.text = degree
    }
}
