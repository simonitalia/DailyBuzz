//
//  ViewController.+Extensions.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/1/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

fileprivate var spinner = ActivityIndicatorViewController()

extension UIViewController {
	
	//MARK: - UIAlertController/s
	
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
	
	//MARK: - UIActivity Spinner
	func activityIndicator(show: Bool) {
	
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			
			//add activitySpinnerVC to parentVC
			if show {
				self.addChild(spinner)
				spinner.view.frame = self.view.frame
				self.view.addSubview(spinner.view)
				spinner.didMove(toParent: self)
				
			//remove activitySpinnerVC from parentVC
			} else {
				spinner.willMove(toParent: nil)
				spinner.view.removeFromSuperview()
				spinner.removeFromParent()
			}
		}
	}
}
