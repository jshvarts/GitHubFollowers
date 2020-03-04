//
//  String+Ext.swift
//  GitHubFollowers
//
//  Created by James Shvarts on 3/1/20.
//  Copyright © 2020 James Shvarts. All rights reserved.
//

import Foundation

extension String {
  // not used in this project due to JSON decoder date strategy
  func convertToDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = .current
    
    return dateFormatter.date(from: self)
  }
  
  func convertToDisplayFormat() -> String {
    guard let date = self.convertToDate() else { return "Date not available" }
    return date.convertToMonthYearFormat()
  }
}
