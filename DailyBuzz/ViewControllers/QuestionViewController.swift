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
	internal var questions: [DBItem]? {
		didSet {
			configureUI()
		}
	}
	
	internal var nextQuestionIndex = 0
	internal var currentQuestion: DBItem!
	
	
	//MARK: - Storyboard
	
	//IB Outlets
	@IBOutlet weak var headlineImageView: UIImageView!
	@IBOutlet weak var headlineImageActivityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var pointsPossibleLabel: UILabel!
	@IBOutlet weak var playerTotalScoreProgressView: UIProgressView!
	@IBOutlet var answerButtons: [UIButton]!
	@IBOutlet weak var skipQuestionButton: UIButton!
	
	//IB Actions
	@IBAction func skipQuestionButtonTapped(_ sender: Any) {
		getNextQuestion()
	}
	
	
	
	
	//MARK: - View Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getGameQuestions()
		configureUserInteraction(to: false)
	}
	
	
	//MARK: - VC Setup
	private func configureUserInteraction(to enabled: Bool) {
		view.isUserInteractionEnabled = enabled
	}
	
	
	@objc func getGameQuestions() {
		
		activityIndicator(show: true)
		
		DBNetworkController.shared.fetchJsonFeed { [unowned self] result in
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
	
	//MARK: - UI
	
	private func configureUI() {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.configureNavigationBar()
			self.configurePointsPossibleLabel()
			self.configureSkipQuestionButton()
			self.getNextQuestion()
		}
	}
	
	
	internal func updateUI() {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.configureHeadlineImageView()
			self.congifureAnswerButtons()
		}
	}
	
	
	private func configureNavigationBar() {
		title = "Daily Buzz"
	}
	
	
	private func headlineActivityIndicator(show: Bool) {
		
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			
			self.headlineImageActivityIndicator.isHidden = !show
			show ? self.headlineImageActivityIndicator.startAnimating() : self.headlineImageActivityIndicator.stopAnimating()
			show ? self.view.bringSubviewToFront(self.headlineImageActivityIndicator) : self.view.sendSubviewToBack(self.headlineImageActivityIndicator)
		}
	}
	
	
	@objc private func configureHeadlineImageView() {
		
		//start activity view
		headlineActivityIndicator(show: true)
		
		//fecth image
		let imageUrl = currentQuestion.imageUrl
		
		currentQuestion?.fetchItemHeadlineImage(from: imageUrl) { [unowned self] (result) in
			self.headlineActivityIndicator(show: false)
			
			switch result {
				case .success(let image):
					DispatchQueue.main.async {
						self.headlineImageView.image = image
						self.configureUserInteraction(to: true)
				}
				
				case .failure(let error):
					self.presentAlert(title: "Headline Image Download Failed!", message: error.rawValue, completionHandler: #selector(self.configureHeadlineImageView))
			}
		}
	}
	
	
	private func configurePointsPossibleLabel() {
		pointsPossibleLabel.text = "+2 Points Coming Your Way!"
	}
	
	
	private func congifureAnswerButtons() {
		guard let question = currentQuestion else { return }
		
		//configure button presentation
		answerButtons.forEach({
			$0.setTitleColor(.black, for: .normal)
			$0.backgroundColor = .white
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
}
