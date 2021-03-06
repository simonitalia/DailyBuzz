//
//  Items.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/1/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

//items object definition
struct DBItem: Codable, Error {
	let correctAnswerIndex: Int
	let imageUrl: String
	let standFirst: String
	let storyUrl: String
	let section: String
	let headlines: [String]

	enum CodingKeys: String, CodingKey {
		case correctAnswerIndex, imageUrl, standFirst, storyUrl, section, headlines
	}
	
	
	func fetchItemHeadlineImage(from urlString: String, completion: @escaping (Result<UIImage, DBError>) -> Void) {
		
		let url = urlString.convertStringUrlToHttpsUrl()
		let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

			//handles errors
			if let error = error {
				completion(.failure(error as! DBError))
				return
			}

			//check for server response code 200, else bail out
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completion(.failure(error as! DBError))
				return
			}

			//if success, pass image back
			if let data = data {
				guard let image = UIImage(data: data) else {
					completion(.failure(error as! DBError))
					return
				}
				
				completion(.success(image))
			}
		}
		
		task.resume()
	}
	
	
	func isAnswerIndexCorrect(for index: Int) -> Bool {
		if correctAnswerIndex == index {
			return true
		} else {
			return false
		}
	}
	
	
	func getCorrectAnswerIndex() -> Int {
		return correctAnswerIndex
	}
}
