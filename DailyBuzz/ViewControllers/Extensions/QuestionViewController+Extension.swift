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
	private func answerButtonTapped(with tag: Int) {
		guard let question = currentQuestion else { return }
		
		if tag == question.correctAnswerIndex {
			
			//correct answer
		} else {
			//wrong answer
			
		}
	}
	
	
	internal func getNextQuestion() {
		currentQuestion = questions?[nextQuestionIndex]
		nextQuestionIndex += 1
		print("Next Question index: \(nextQuestionIndex).")
		updateUI()
		
	}
}

