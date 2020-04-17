//
//  Date+Extension.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 17/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}
