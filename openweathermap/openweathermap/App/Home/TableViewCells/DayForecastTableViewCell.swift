//
//  Untitled.swift
//  openweathermap
//
//  Created by Kagan Girgin on 24/07/2025.
//

import UIKit

final class DayForecastTableViewCell: UITableViewCell {
    // MARK: Properties
    private var collectionViewSource: ForecastCollectionViewSource?
    
    // MARK: UI Components
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            ForecastCollectionViewCell.self,
            forCellWithReuseIdentifier: ForecastCollectionViewCell.description()
        )
        return collectionView
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
        contentView.addSubview(collectionView)
        
        //MARK: Constraints
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func updateCell(data: [List]) {
        collectionViewSource = ForecastCollectionViewSource(data: data)
        collectionView.dataSource = collectionViewSource
        collectionView.delegate = collectionViewSource
        collectionView.reloadData()
    }
}
