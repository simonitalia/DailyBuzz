//
//  ViewController.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/1/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
	
	//MARK: - Local Properties
	
	private var questions: [DBItem]? {
		didSet {
			print("Success! Questions fetched!")
		}
	}

	
	//MARK: - View Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()

		getGameQuestions()
	}
	
	
	@objc func getGameQuestions() {
		DBNetworkController.shared.fetchJsonFeed { [weak self] result in
			guard let self = self else { return }
			
			switch result {
				case .success(let questions):
					self.questions = questions
		
				//display alert to user on error
				case .failure(let error):
					self.presentAlert(title: "We had a problem!", message: error.rawValue, completionHandler: #selector(self.getGameQuestions))
			}
		}
	}
}



