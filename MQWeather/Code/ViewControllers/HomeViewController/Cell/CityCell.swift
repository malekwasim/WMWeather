//
//  CityCell.swift
//  MQWeather
//
//  Created by Wasim on 08/05/21.
//

import UIKit

protocol CityCellDelegate: class {
    func removeCityAtIndex(_ index: Int)
}

class CityCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    weak var delegate: CityCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(_ city: UserCities, indexPath: IndexPath) {
        lblName.text = city.name
        btnDelete.tag = indexPath.row
        btnDelete.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        delegate?.removeCityAtIndex(sender.tag)
    }

}
