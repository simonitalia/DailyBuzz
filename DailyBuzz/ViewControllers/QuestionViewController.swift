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
	
	enum Identifier {
		enum Storyboard {
			static let answerVC = "AnswerVC"
		}
    }
	
	private var spinner: ActivityIndicatorViewController!
	
	//question tracking
	var question: DBItem!
	
	var questions: [DBItem]? {
		didSet {
			configureUI()
		}
	}
	
	var questionIndex = 0  {
	   didSet {
		   updatePlayerProgressBar(with: questionIndex)
	   }
	}
	
	var playerScore = 0 {
		didSet {
			updatePlayerScoreLabel(with: playerScore)
		}
	}
	
	var headlineAnswer: DBHeadlineAnswer! 
	
	
	//MARK: - Storyboard IB Outlets / Actions
	
	//IB Outlets
	
	@IBOutlet weak var headlineImageView: UIImageView!
	@IBOutlet weak var headlineImageActivityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var playerPointsLabel: UILabel!
	@IBOutlet weak var playerScoreProgressView: UIProgressView!
	@IBOutlet var answerButtons: [UIButton]!
	@IBOutlet weak var skipQuestionButton: UIButton!
	
	//IB Actions
	@IBAction func skipQuestionButtonTapped(_ sender: Any) {
		getQuestion()
	}
	
	
	@IBAction func answerButtonTapped(_ sender: UIButton) {
		playerAnswerSubmitted(with: sender.tag)
	}
	
	
	//MARK: - UIView Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getGameQuestions()
		hideViews(true)
	}
	
	
	//MARK: - Initial VC Setup
	
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
	
	
	private func hideViews(_ hide: Bool) {
		headlineImageView.isHidden = hide
		playerPointsLabel.isHidden = hide
		playerScoreProgressView.isHidden = hide
		answerButtons.forEach( { $0.isHidden = hide } )
		skipQuestionButton.isHidden = hide
	}
	
	
	//MARK: - UI Setup
	
	//triggered after Questions are fetched
	private func configureUI() {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			
			//configure UI elements
			self.configureNavigationBar()
			self.configureHeadlineImageView()
			self.configurePlayerScoreProgressView()
			self.updatePlayerScoreLabel(with: 0)
			self.configureSkipQuestionButton()
			self.hideViews(false) //show views
			
			//get question
			self.getQuestion()
		}
	}
	
	
	private func configureNavigationBar() {
		title = "Daily Buzz"
	}
	
	
	private func configureHeadlineImageView() {
		headlineImageView.layer.cornerRadius = Constants.ImageView.cornerRadius
	}
	
	
	private func headlineActivityIndicator(show: Bool) {
		
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			
			self.headlineImageActivityIndicator.isHidden = !show
			show ? self.headlineImageActivityIndicator.startAnimating() : self.headlineImageActivityIndicator.stopAnimating()
			show ? self.view.bringSubviewToFront(self.headlineImageActivityIndicator) : self.view.sendSubviewToBack(self.headlineImageActivityIndicator)
		}
	}
	
	
	@objc func getQuestionHeadlineImage() {
		
		//start activity view
		headlineActivityIndicator(show: true)
		
		//fecth image
		let imageUrl = question.imageUrl
		
		question?.fetchItemHeadlineImage(from: imageUrl) { [unowned self] (result) in
			self.headlineActivityIndicator(show: false)
			
			switch result {
				case .success(let image):
					DispatchQueue.main.async {
						self.headlineImageView.image = image
						self.view.isUserInteractionEnabled = true //enable user interactiono
				}
				
				case .failure(let error):
					self.presentAlert(title: "Headline Image Download Failed!", message: error.rawValue, completionHandler: #selector(self.getQuestionHeadlineImage))
			}
		}
	}
	

	private func configurePlayerScoreProgressView() {
		playerScoreProgressView.progress = 0
		playerScoreProgressView.trackTintColor = .white
		playerScoreProgressView.progressTintColor = .systemGreen
	}
	
	
	func congifureAnswerButtons() {
		guard let question = question else { return }
		
		//configure button presentation
		answerButtons.forEach({
			$0.setTitleColor(.white, for: .normal)
			$0.backgroundColor = .systemPurple
			$0.layer.cornerRadius = Constants.Button.cornerRadius
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
		skipQuestionButton.backgroundColor = .darkGray
		skipQuestionButton.layer.cornerRadius = Constants.Button.cornerRadius
	}
}
