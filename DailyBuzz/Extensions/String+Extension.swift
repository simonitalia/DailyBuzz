//
//  String+Extension.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/2/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

extension String {
	

	func convertStringUrlToHttpsUrl() -> URL {
		let url = URL(string: self)!
		var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
		components.scheme = "https"
		return components.url!
	}
	
	
	func convertToAttributedText(size: CGFloat, location: Int, length: Int) -> NSMutableAttributedString {
		let attributedText = NSMutableAttributedString(string: self)
		let bold = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: size)]
		attributedText.setAttributes(bold, range: NSRange(location: location, length: length))
		return attributedText
	}
}
