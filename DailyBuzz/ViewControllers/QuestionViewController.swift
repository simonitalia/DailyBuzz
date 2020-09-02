//
//  ViewController.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/1/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
	
	//MARK: - Class Properties
	
	private var spinner: ActivityIndicatorViewController!
	
	//question tracking
	private var currentQuestionIndex = 0
	private var questions: [DBItem]? {
		didSet {
			updateUI()
		}
	}
	
	private var question: DBItem!
	
	//MARK: - IB Outlets
	@IBOutlet weak var headlineImageView: UIImageView!
	@IBOutlet weak var pointsPossibleLabel: UILabel!
	@IBOutlet weak var playerTotalScoreProgressView: UIProgressView!
	@IBOutlet var answerButtons: [UIButton]!
	@IBOutlet weak var skipQuestionButton: UIButton!
	
	//MARK: - View Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getGameQuestions()
	}
	
	@objc func getGameQuestions() {
		
		activityIndicator(show: true)
		
		DBNetworkController.shared.fetchJsonFeed { [weak self] result in
			guard let self = self else { return }
			
			self.activityIndicator(show: false)
			
			switch result {
				case .success(let questions):
					self.questions = questions
		
				//display alert to user on error
				case .failure(let error):
					self.presentAlert(title: "We had a problem!", message: error.rawValue, completionHandler: #selector(self.getGameQuestions))
			}
		}
	}
	
	//MARK: - UI Configuration
	
	private func updateUI() {
		configureCurrentQuestion()
		
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.configureNavigationBar()
			self.configurePointsPossileLabel()
			self.congifureAnswerButtons()
			self.configureSkipQuestionButton()
		}
	}
	
	
	private func configureCurrentQuestion() {
		question = questions?[currentQuestionIndex]
	}
	
	
	private func configureNavigationBar() {
		let barButtonItems = [UILabel(), UILabel()]
		
		for (index, barButtonItem) in barButtonItems.enumerated() {
			if index == 0 {
				barButtonItem.text = "Guess this headline!"
				barButtonItem.textAlignment = .left
				self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: barButtonItem)
			} else {
				barButtonItem.text = "Entertainment"
				barButtonItem.textAlignment = .right
				self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barButtonItem)
			}
		}
	}
	
	
	private func configureHeadlineImageView() {
		
		//start activity view
		
		
	}
	
	
	private func configurePointsPossileLabel() {
		pointsPossibleLabel.text = "+2 Points Coming Your Way!"
	}
	
	private func congifureAnswerButtons() {
		guard let question = question else { return }
		
		//configure button presentation
		answerButtons.forEach({
			$0.setTitleColor(.white, for: .normal)
			$0.backgroundColor = .systemBlue
			$0.layer.cornerRadius = 5
		})
		
		
		//set button title text to possible answers
		for (index, button) in answerButtons.enumerated() {
			guard index < question.headlines.count else { return } //protect from index out of bounds errors
			button.setTitle(question.headlines[index], for: .normal)
		}
	}
	
	
	private func configureSkipQuestionButton() {
		skipQuestionButton.setTitle("Skip Question! I give up", for: .normal)
		skipQuestionButton.setTitleColor(.white, for: .normal)
		skipQuestionButton.backgroundColor = .systemGray
		skipQuestionButton.layer.cornerRadius = 5
	}
	
	
	private func answerButtonTapped(with tag: Int) {
		guard let question = question else { return }
		
		if tag == question.correctAnswerIndex {
			
			//correct answer
		} else {
			//wrong answer
			
		}
	}
}
