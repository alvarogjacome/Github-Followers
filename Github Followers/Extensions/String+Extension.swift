//
//  String+Extension.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 17/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = .current

        return dateFormatter.date(from: self)
    }

    func convertToDisplayFormat() -> String {
        return self.convertToDate()?.convertToMonthYearFormat() ?? "N/A"
    }
}
