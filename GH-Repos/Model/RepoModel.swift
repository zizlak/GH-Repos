//
//  RepoModel.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import Foundation

// MARK: - RepoModel
struct RepoModel: Decodable {
    // [df] what if all nil?
    var fullName: String?
    var description: String?
    var owner: Owner?

    init?(fullName: String? = nil, description: String? = nil, owner: Owner? = nil) {
        guard fullName != nil || description != nil || owner != nil else { return nil }

        self.fullName = fullName
        self.description = description
        self.owner = owner
    }

    init?() {
        return nil
    }
}

struct Owner: Decodable {
    var avatarUrl: String?
}

// MARK: - FilteredRepos
struct FilteredRepos: Decodable {
    var items: [RepoModel]?
}
