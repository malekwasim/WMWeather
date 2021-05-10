//
//  HelpViewController.swift
//  MQWeather
//
//  Created by Wasim on 09/05/21.
//

import UIKit
import WebKit

internal final class HelpViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.title = "Help"
        let htmlHeader = "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head>"

        let htmlString = """
        <!DOCTYPE html>
        <html>
        <head>
        <title>Page Title</title>
        </head>
        <body>

        <h1>Help</h1>
        <p>How to add new city?</p>
        <ul>
        <li>Tap on + icon
        <li>Tap on map to select your city to bookmark
        <li>Tap on Save to bookmark city
        </ul>
        <p>How to add remove city?</p>
        <ul>
        <li>Tap on Trash icon on list on home page to remvoe city
        </ul>
        <p>How to check the weather of particular city?</p>
        <ul>
        <li>Tap on City name you want to see weather report
        <li>It will display the weatehr for selected city
        </ul>
        </body>
        </html>

        """
        
        webView.loadHTMLString(htmlHeader + htmlString, baseURL: nil)
    }
    

}
