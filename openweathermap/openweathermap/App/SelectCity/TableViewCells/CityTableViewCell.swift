//
//  CityTableViewCell.swift
//  openweathermap
//
//  Created by Kagan Girgin on 17/07/2025.
//

import UIKit

final class CityTableViewCell: UITableViewCell {
    // MARK: UI Components
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .black
        return label
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
        contentView.addSubview(lblTitle)
        
        //MARK: Constraints
        NSLayoutConstraint.activate([
            lblTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lblTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            lblTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func updateCell(title: String) {
        lblTitle.text = title
    }
}
