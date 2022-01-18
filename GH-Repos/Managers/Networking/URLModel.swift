//
//  URLModel.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import Foundation

struct URLModel {

    // MARK: - Properties
    let scheme: String
    let host: String
    let path: [String]

    var queryItems: [URLQueryItem]?

    // MARK: - URL
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host

        for path in path {
            let pathWithSlash = "/" + path
            components.path.append(pathWithSlash)
        }

        components.queryItems = queryItems
        return components.url
    }
}
