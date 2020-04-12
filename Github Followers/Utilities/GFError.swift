//
//  GFError.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 11/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidRequest = "This username created an invalid request. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received form de server was invalid. Please try again."
}
