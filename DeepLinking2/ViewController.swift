//
//  ViewController.swift
//  DeepLinking2
//
//  Created by Daniel Hjärtström on 2020-06-23.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let temp = UIButton()
        temp.setTitle("Go to first app", for: .normal)
        temp.setTitleColor(UIColor.white, for: .normal)
        temp.addTarget(self, action: #selector(didTouchButton), for: .touchUpInside)
        temp.backgroundColor = UIColor.blue
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        button.isHidden = false
    }

    @objc private func didTouchButton() {
        UIApplication.openAppWith(identifier: "myFirstApp://", fallback: "https://kiloloco.com")
    }

}

extension UIApplication {
    static func openAppWith(identifier: String, fallback: String) {
        let application = UIApplication.shared
        let message = "Message from the second app!".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let websiteURL = URL(string: fallback) else { return }
        
        if let appURL = URL(string: "\(identifier)\(message)") {
            if application.canOpenURL(appURL) {
                application.open(appURL)
            } else {
                application.open(websiteURL)
            }
        } else {
            application.open(websiteURL)
        }
    }
}

