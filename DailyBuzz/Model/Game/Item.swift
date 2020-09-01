//
//  Items.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/1/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

//items object definition
struct Item: Codable, Error {
	let correctAnswerIndex: Int!
	let imageUrl: String!
	let standFirst: String!
	let storyUrl: String!
	let section: String!
	let headlines: [String]!

	enum CodingKeys: String, CodingKey {
		case correctAnswerIndex, imageUrl, standFirst, storyUrl, section, headlines
	}

//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		correctAnswerIndex = try values.decodeIfPresent(Int.self, forKey: .correctAnswerIndex)
//		imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
//		standFirst = try values.decodeIfPresent(String.self, forKey: .standFirst)
//		storyUrl = try values.decodeIfPresent(String.self, forKey: .storyUrl)
//		section = try values.decodeIfPresent(String.self, forKey: .section)
//		headlines = try values.decodeIfPresent([String].self, forKey: .headlines)
//	}
}
