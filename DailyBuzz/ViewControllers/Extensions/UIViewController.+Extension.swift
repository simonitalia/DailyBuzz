//
//  ViewController.+Extensions.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/1/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var activityInidicatorVC = ActivityIndicatorViewController()

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
				self.addChild(activityInidicatorVC)
				activityInidicatorVC.view.frame = self.view.frame
				self.view.addSubview(activityInidicatorVC.view)
				activityInidicatorVC.didMove(toParent: self)
				
			//remove activitySpinnerVC from parentVC
			} else {
				activityInidicatorVC.willMove(toParent: nil)
				activityInidicatorVC.view.removeFromSuperview()
				activityInidicatorVC.removeFromParent()
			}
		}
	}
	
	//MARK: Open Load Website
	func loadWebsite(for urlString: String) {
        DispatchQueue.main.async { [unowned self] in
			let url = urlString.convertStringUrlToHTTPS()
            let safariVC = SFSafariViewController(url: url)
            self.present(safariVC, animated: true, completion: nil)
        }
    }
}
