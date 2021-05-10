//
//  ViewController.swift
//  MQWeather
//
//  Created by Wasim on 07/05/21.
//

import UIKit

internal final class HomeViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var arrCities = [UserCities]()
    var dataSource : TableViewDataSource<UserCities>!
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getCities()
    }
    
    private func setupView() {
        self.title = "Cities"
        setNavBar()
        
    }
    
    func setNavBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(btnAddTapped(_:)))
        navigationItem.setRightBarButton(addButton, animated: true)
        
        let helpButton = UIBarButtonItem(title: "Help", style: .plain, target: self,
            action: #selector(btnHelpTapped(_:))
        )
        
        navigationItem.setLeftBarButton(helpButton, animated: true)
    
    }
    
    @objc func btnAddTapped(_ sender: UIButton) {
        push(UIStoryboard.mapVC)
    }
    @objc func btnHelpTapped(_ sender: UIButton) {
        push(UIStoryboard.helpVC)
    }
    
    //MARK: - Get City List
    func getCities() {
        arrCities = UserCitiesDBManager.shared.getAllcities()
        dataSource = TableViewDataSource.make(for: arrCities, parentVC: self)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.reloadData()
    }


}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = arrCities[indexPath.row]
        navigateToCity(city)
    }
    
    func navigateToCity(_ city: UserCities) {
        let vc = UIStoryboard.weatherVC
        vc.city = city
        self.push(vc)
        
    }
}

extension HomeViewController: CityCellDelegate {
    func removeCityAtIndex(_ index: Int) {
        let city = arrCities[index]
        UserCitiesDBManager.shared.removeCity(city.id)
        getCities()
    }
}
