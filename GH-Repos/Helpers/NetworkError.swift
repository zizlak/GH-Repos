//
//  ReposError.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import Foundation

// [df] probably bad naming
enum NetworkError: String, Error {

    case invalidKeyWord = "Invalid KeyWord"
    case unableToComplete = "Unable to complete the request"
    case invalidResponse = "Invalid response from the server"
    case invalidData = "The data recieved from the server is invalid"
}
