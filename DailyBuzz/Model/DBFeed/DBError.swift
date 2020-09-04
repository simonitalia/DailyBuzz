//
//  DBError.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/1/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

//custom, user friendly error definition
enum DBError: String, Error {
	
	//remote network errors
	case httpError = "Remote server responded with an error. Please try again."
	case feedFetchError = "Failed to fetch questions from remote server. Please try again."
	
	//local / json file errors
	case fileError = "Could not load questions. Please try again."
	
	//image missing
	case missingImage = "Headline image is missing."
}


//feed error response definition
extension DBError {
	struct DBFeedErrorResponse: LocalizedError {
		let code: String
		let message: String
	}
}



