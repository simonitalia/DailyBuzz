//
//  Question.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/2/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

//MARK: - Game Logic Methods

extension QuestionViewController {
	
	//MARK: -  Player Score Helpers
	
	internal func playerSubmittedAnswer(with index: Int) {
		let isAnswerCorrect = question.checkCorrectAnswerIndex(against: index)
		
		if isAnswerCorrect {
			playerScore += 2
		
		} else {
			guard playerScore != 0 else { return } //guard player score from going into negative
			playerScore -= 1
		}
	}
	
	
	internal func updatePlayerScoreLabel(with score: Int) {
		
		//convert score to string
		let stringScore = String(score)
		
		//set string attrributes
		let text = "+\(score) Points Coming Your Way!"
		let attributedText = NSMutableAttributedString(string: text)
		let bold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
		attributedText.setAttributes(bold, range: NSRange(location: 1, length: stringScore.count))
		pointsPossibleLabel.attributedText = attributedText
	}
	
	
	internal func updatePlayerProgressBar(with currentQuestionIndex: Int) {
		guard let questions = questions else { return }
		let progressValue = Float(currentQuestionIndex) / Float(questions.count)
		playerScoreProgressView.progress = progressValue
	}
	
	
	//MARK: - Question Helpers
	
	internal func getNextQuestion() {
		question = questions?[questionIndex]
		questionIndex += 1
		updateUI()
	}
	
	
	//MARK: - UI Helpers
	
	private func updateUI() {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.getQuestionHeadlineImage()
			self.congifureAnswerButtons()
		}
	}
}

