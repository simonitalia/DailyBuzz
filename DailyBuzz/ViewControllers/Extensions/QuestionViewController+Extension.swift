//
//  Question.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/2/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

extension QuestionViewController {
	
	//MARK: -  Player Score Helpers
	
	internal func playerSubmittedAnswer(with index: Int) {
		let isAnswerCorrect = currentQuestion.checkCorrectAnswerIndex(against: index)
		
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
	
	
	internal func updatePlayerProgressBar(with score: Int) {
		guard let questions = questions else { return }
		let maxPossibleScore = Float(questions.count * 2)  //total Qs * max points
		let progressValue = Float(score) / maxPossibleScore
		playerScoreProgressView.progress = progressValue
	}
	
	
	//MARK: - Question Helpers
	
	internal func getNextQuestion() {
		currentQuestion = questions?[nextQuestionIndex]
		nextQuestionIndex += 1
		updateUI()
	}
}

