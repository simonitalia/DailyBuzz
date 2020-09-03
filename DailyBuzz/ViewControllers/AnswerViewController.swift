//
//  AnswerResponseViewController.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/2/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

//Delegate to fetch new Question
protocol AnswerViewControllerDelegate {
	func getQuestion()
}

class AnswerViewController: UIViewController {
	
	var delegate: AnswerViewControllerDelegate!
	
	var headlineAnswer: DBHeadlineAnswer!
	var playerScore: Int!
	var isAnswerCorrect: Bool!
	
	
	//MARK: - View Lifecycyle
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		delegate.getQuestion()
	}
	
}
