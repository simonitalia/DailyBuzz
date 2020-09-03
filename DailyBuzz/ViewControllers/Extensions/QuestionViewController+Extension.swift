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
	
	func playerAnswerSubmitted(with index: Int) {
		let isAnswerCorrect = question.isAnswerIndexCorrect(for: index)
		
		if isAnswerCorrect {
			playerScore += 2
			
		} else {
			if playerScore > 0 { //guard player score from going into negative
				playerScore -= 1
			}
		}
		
		//present answerVC
		presentAnswerVC(with: isAnswerCorrect)
	}
	
	
	func updatePlayerScoreLabel(with score: Int) {
		
		//convert score to string
		let stringScore = String(score)
		
		//set string attrributes
		let text = "+\(score) Points Coming Your Way!"
		let attributedText = NSMutableAttributedString(string: text)
		let bold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
		attributedText.setAttributes(bold, range: NSRange(location: 1, length: stringScore.count))
		pointsPossibleLabel.attributedText = attributedText
	}
	
	
	func updatePlayerProgressBar(with currentQuestionIndex: Int) {
		guard let questions = questions else { return }
		let progressValue = Float(currentQuestionIndex) / Float(questions.count)
		playerScoreProgressView.progress = progressValue
	}
	
	
	//MARK: - Question Helpers
	
	func getQuestion() {
		question = questions?[questionIndex]
		questionIndex += 1 //update question index to next question
		updateUI()
	}
	
	
	//MARK: - UI Helpers
	
	//Show Question
	private func updateUI() {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.getQuestionHeadlineImage()
			self.congifureAnswerButtons()
		}
	}
	
	
	private func createHeadlineAnswer() -> DBHeadlineAnswer {
		
		//create player answer object
		let headline = question.headlines[question.correctAnswerIndex]
		let storyURL = question.storyUrl
		let image = headlineImageView.image
		
		return DBHeadlineAnswer(headlineImage: image, headline: headline, storyUrl: storyURL)
	}
	

	//MARK: - Navigation
	
	private func presentAnswerVC(with isCorrect: Bool) {
		
		//setup destinationVC
		let vc = self.storyboard?.instantiateViewController(withIdentifier: Identifier.Storyboard.answerVC) as! AnswerViewController
		vc.headlineAnswer = createHeadlineAnswer()
		vc.playerScore = playerScore
		vc.isAnswerCorrect = isCorrect
			
		//presentVC
		present(vc, animated: true, completion: nil)
	}
}

