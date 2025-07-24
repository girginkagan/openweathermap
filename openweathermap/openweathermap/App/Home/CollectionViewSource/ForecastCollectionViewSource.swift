//
//  ForecastCollectionViewSource.swift
//  openweathermap
//
//  Created by Kagan Girgin on 24/07/2025.
//

import UIKit

// MARK: UICollectionViewDataSource
final class ForecastCollectionViewSource: NSObject, UICollectionViewDataSource {
    private let data: [List]
    
    init(data: [List]) {
        self.data = data
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        data.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ForecastCollectionViewCell.description(),
            for: indexPath
        ) as? ForecastCollectionViewCell else { return UICollectionViewCell() }
        let data = data[indexPath.row]
        let date = data.dtTxt?.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
        let isMetric = DataProvider.sharedInstance.selectedUnit == "metric"
        
        cell.updateCell(
            time: date?.toString(dateFormat: "HH:mm") ?? "",
            image: data.weather?.first?.icon ?? "",
            degree: String(Int(data.main?.temp ?? 0)) + (isMetric ? "°C" : "°F")
        )
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ForecastCollectionViewSource: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: 71,
            height: 100
        )
    }
}
