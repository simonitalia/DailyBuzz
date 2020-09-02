//
//  String+Extension.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/2/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

extension String {
	
	//MARK: - Convert String to HTTPS Url
	func convertStringUrlToHTTPS() -> URL {
		let url = URL(string: self)!
		var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
		components.scheme = "https"
		return components.url!
	}
}
