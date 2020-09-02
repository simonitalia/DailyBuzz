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
	private var playerScore = 0 {
		didSet {
			configurePlayerScoreLabel(with: playerScore)
		}
	}
	
	
	//MARK: - Storyboard
	
	//IB Outlets
	@IBOutlet weak var headlineImageView: UIImageView!
	@IBOutlet weak var headlineImageActivityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var pointsPossibleLabel: UILabel!
	@IBOutlet weak var playerScoreProgressView: UIProgressView!
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
		hideViews(true)
	}
	
	
	//MARK: - VC Setup
	private func hideViews(_ hide: Bool) {
		view.isUserInteractionEnabled = !hide
		
		pointsPossibleLabel.isHidden = hide
		playerScoreProgressView.isHidden = hide
		answerButtons.forEach( { $0.isHidden = hide } )
		skipQuestionButton.isHidden = hide
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
	
	//MARK: - UI Configuration
	
	private func configureUI() {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			
			//configure UI elements
			self.configureNavigationBar()
			self.configureHeadlineImageView()
			self.configurePlayerTotalScoreProgressView()
			self.configurePlayerScoreLabel(with: 0)
			self.configureSkipQuestionButton()
			
			//load question
			self.getNextQuestion()
		}
	}
	
	
	internal func updateUI() {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.getQuestionHeadlineImage()
			self.congifureAnswerButtons()
		}
	}
	
	
	private func configureNavigationBar() {
		title = "Daily Buzz"
	}
	
	
	private func configureHeadlineImageView() {
		headlineImageView.layer.cornerRadius = 15
	}
	
	
	private func headlineActivityIndicator(show: Bool) {
		
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			
			self.headlineImageActivityIndicator.isHidden = !show
			show ? self.headlineImageActivityIndicator.startAnimating() : self.headlineImageActivityIndicator.stopAnimating()
			show ? self.view.bringSubviewToFront(self.headlineImageActivityIndicator) : self.view.sendSubviewToBack(self.headlineImageActivityIndicator)
		}
	}
	
	
	@objc private func getQuestionHeadlineImage() {
		
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
						self.hideViews(false)
				}
				
				case .failure(let error):
					self.presentAlert(title: "Headline Image Download Failed!", message: error.rawValue, completionHandler: #selector(self.getQuestionHeadlineImage))
			}
		}
	}
	

	private func configurePlayerScoreLabel(with score: Int) {
		
		let stringScore = String(score)
		let text = "+\(score) Points Coming Your Way!"
		let attributedText = NSMutableAttributedString(string: text)
		
		let bold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
		
		attributedText.setAttributes(bold, range: NSRange(location: 1, length: stringScore.count))
		
		pointsPossibleLabel.attributedText = attributedText
	}
	
	
	private func configurePlayerTotalScoreProgressView() {
		playerScoreProgressView.trackTintColor = .white
		playerScoreProgressView.progressTintColor = .systemGreen
	}
	
	
	private func congifureAnswerButtons() {
		guard let question = currentQuestion else { return }
		
		//configure button presentation
		answerButtons.forEach({
			$0.setTitleColor(.white, for: .normal)
			$0.backgroundColor = .systemPurple
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
		skipQuestionButton.backgroundColor = .darkGray
		skipQuestionButton.layer.cornerRadius = 5
	}
}
