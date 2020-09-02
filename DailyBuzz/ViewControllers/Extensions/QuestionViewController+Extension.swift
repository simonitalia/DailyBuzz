//
//  Question.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/2/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

extension QuestionViewController {

	//MARK: - Question Helpers
	
	internal func playerSubmittedAnswer(with index: Int) {
		let isAnswerCorrect = currentQuestion.checkCorrectAnswerIndex(against: index)
		
		if isAnswerCorrect {
			playerScore += 2
		
		} else {
			guard playerScore != 0 else { return } //guard player score from going into negative
			playerScore -= 1
		}
	}
	
	
	internal func getNextQuestion() {
		currentQuestion = questions?[nextQuestionIndex]
		nextQuestionIndex += 1
		updateUI()
	}
}

