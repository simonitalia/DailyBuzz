//
//  QuestionResponse.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/1/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

//feed response object definition
struct Feed: Codable, Error {
	let product: String!
	let resultSize: Int!
	let version: Int!
	let items: [Item]!

	enum CodingKeys: String, CodingKey {
		case product, resultSize, version, items
	}

//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		product = try values.decodeIfPresent(String.self, forKey: .product)
//		resultSize = try values.decodeIfPresent(Int.self, forKey: .resultSize)
//		version = try values.decodeIfPresent(Int.self, forKey: .version)
//		items = try values.decodeIfPresent([Item].self, forKey: .items)
//	}
}
