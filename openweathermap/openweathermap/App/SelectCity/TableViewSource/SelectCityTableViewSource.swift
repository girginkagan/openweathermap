//
//  Untitled.swift
//  openweathermap
//
//  Created by Kagan Girgin on 17/07/2025.
//

import UIKit

protocol SelectCityTableViewSourceDelegate: AnyObject {
    func didTapCity(data: CitiesResponseModelElement)
}

// MARK: UITableViewDataSource
final class SelectCityTableViewSource: NSObject, UITableViewDataSource {
    private let data: CitiesResponseModel
    private weak var delegate: SelectCityTableViewSourceDelegate?
    
    init(
        data: CitiesResponseModel,
        delegate: SelectCityTableViewSourceDelegate?
    ) {
        self.data = data
        self.delegate = delegate
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        data.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CityTableViewCell.description(),
            for: indexPath
        ) as? CityTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.updateCell(title: "\(data[indexPath.row].name ?? "") / \(data[indexPath.row].country ?? "")" )
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension SelectCityTableViewSource: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        56
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        delegate?.didTapCity(data: data[indexPath.row])
    }
}
