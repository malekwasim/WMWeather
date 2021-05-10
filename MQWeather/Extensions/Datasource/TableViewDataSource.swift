//
//  TableViewDataSource.swift
//  MQWeather
//
//  Created by Wasim on 08/05/21.
//

import UIKit

class TableViewDataSource<Model>: NSObject,UITableViewDataSource {

    typealias CellConfigurator = (Model,IndexPath, UITableViewCell) -> Void
    var models: [Model]
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    init(models: [Model],
         reuseIdentifier: String,
         cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier,
            for: indexPath
        )
        
        cellConfigurator(model,indexPath,cell)
        
        return cell
    }
}
extension TableViewDataSource where Model == UserCities {
    static func make(for media: [UserCities],parentVC:UIViewController?,
                     reuseIdentifier: String = CityCell.identifier) -> TableViewDataSource {
        return TableViewDataSource(
            models: media,
            reuseIdentifier: reuseIdentifier
        ) { (item,indexPath, cell) in
            let topCell = cell as! CityCell
            if let vc = parentVC as? HomeViewController {
                topCell.delegate = vc as? CityCellDelegate
            }
            topCell.setup(item, indexPath: indexPath)
        }
    }
}
