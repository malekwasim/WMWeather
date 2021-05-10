//
//  UIViewController.swift
//  MQWeather
//
//  Created by Wasim on 07/05/21.
//

import UIKit

extension UIViewController {
    class var identifier: String {
        return String(describing: self)
    }
    
    func push(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func popup(_ vc: UIViewController) {
        self.present(vc, animated: true)
    }
    
    func closePopup() {
        self.dismiss(animated: true)
    }
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
}
