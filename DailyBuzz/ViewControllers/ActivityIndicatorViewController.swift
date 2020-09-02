//
//  ActivitySpinnerViewController.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/2/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class ActivityIndicatorViewController: UIViewController {
	var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
