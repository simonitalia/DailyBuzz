//
//  ViewController.+Extensions.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/1/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

extension UIViewController {
	
	//MARK: - Shared UIAlertController
	func presentAlert(title: String, message: String, completionHandler: Selector?) {
		DispatchQueue.main.async {
			let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "Cancel", style: .default))
		
			//include completion action in alert
			if let handler = completionHandler {
				ac.addAction(UIAlertAction(title: "Try again", style: .default, handler: {
					_ in self.perform(handler)
				}))
			}
			
			self.present(ac, animated: true)
		}
	}
}
