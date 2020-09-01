//
//  Items.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/1/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

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
}
