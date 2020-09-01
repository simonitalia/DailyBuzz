//
//  QuestionResponse.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/1/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

//feed response object definition
struct DBFeed: Codable {
	let product: String
	let resultSize: Int
	let version: Int
	let items: [DBItem]

	enum CodingKeys: String, CodingKey {
		case product, resultSize, version, items
	}
}




