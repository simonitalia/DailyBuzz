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

    }
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		delegate.getQuestion()
	}
	
}
