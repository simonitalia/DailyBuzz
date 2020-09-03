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
	
	//MARK: - Class Properties
	
	var delegate: AnswerViewControllerDelegate!
	var headlineAnswer: DBHeadlineAnswer!
	var playerScore: Int!
	var isAnswerCorrect: Bool!
	
	//MARK: - Storyboard IB Outlets / Actions
	
	//IB Outlets
	@IBOutlet weak var playerScoreLabel: UILabel!
	@IBOutlet weak var headlineImageView: UIImageView!
	@IBOutlet weak var headlineLabel: UILabel!
	@IBOutlet weak var readArticleButton: UIButton!
	@IBOutlet weak var getQuestionButton: UIButton!
	@IBOutlet weak var leaderboardButton: UIButton!
	
	//IB Actions
	@IBAction func readArticleButtonTapped(_ sender: UIButton) {
		loadWebsite(for: headlineAnswer.storyUrl)
	}
	
	@IBAction func getQuestionButtonTapped(_ sender: UIButton) {
		delegate.getQuestion()
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func leaderboardButtonTapped(_ sender: UIButton) {
		let urlString = "http://www.dailytelegraph.com.au/sport"
		loadWebsite(for: urlString)
	}
	
	
	//MARK: - View Lifecycyle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureVC()
    }
	
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		delegate.getQuestion()
	}
	
	
	//MARK: - Initial VC Setup
	
	private func configureVC() {
		configureplayerScoreLabel()
		configureHeadlineImageView()
		configureHeadlineLabel()
		configureReadArticleButton()
		configureGetQuestionButton()
		configureLeaderboardButton()
	}
	
	
	//MARK: - Setup UI
	
	private func configureplayerScoreLabel() {
		
		//configure text
		let stringScore = String(playerScore)
		let text: String = {
			isAnswerCorrect ? "✓\nYou Have\n\(stringScore) Points" : "X\nYou Have\n\(stringScore) Points"
		}()
		
		let attributedText = text.convertToAttributedText(size: 20, location: 11, length: stringScore.count)
		playerScoreLabel.attributedText = attributedText
		
		//configure label
		playerScoreLabel.layer.cornerRadius = playerScoreLabel.frame.width / 2
		playerScoreLabel.layer.borderWidth = 3
		playerScoreLabel.layer.backgroundColor = UIColor.systemGreen.cgColor
		playerScoreLabel.layer.borderColor = UIColor.white.cgColor
		playerScoreLabel.textAlignment = .center
	}
	
	
	private func configureHeadlineImageView() {
		headlineImageView.image = headlineAnswer.headlineImage
	}
	
	
	private func configureHeadlineLabel() {
		headlineLabel.text = headlineAnswer.headline
	}
	
	
	private func configureReadArticleButton() {
		readArticleButton.setTitle("Read Article >", for: .normal)
		readArticleButton.layer.cornerRadius = Constants.Button.cornerRadius
	}
	
	
	private func configureGetQuestionButton() {
		getQuestionButton.setTitle("Next Question", for: .normal)
		getQuestionButton.layer.cornerRadius = Constants.Button.cornerRadius
	}
	
	
	private func configureLeaderboardButton() {
		
		let text = "How am I doing in the Leaderboards?"
		let leaderboardsString = "Leaderboards"
		let attributedText = text.convertToAttributedText(size: 16, location: 22, length: leaderboardsString.count)
		attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: text.count))
		leaderboardButton.setAttributedTitle(attributedText, for: .normal)
		
		//view
		leaderboardButton.layer.cornerRadius = Constants.Button.cornerRadius
	}
}
