//
//  ViewController.+Extensions.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/1/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

extension UIViewController {
	
	//MARK: - Shared UIAlertControllers
	func presentAlert(withTitle title: String, andMessage message: String) {
		DispatchQueue.main.async {
			let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "OK", style: .default))
			self.present(ac, animated: true)
		}
	}
}
