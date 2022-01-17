//
//  RepoModel.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import Foundation

//MARK: - RepoModel
struct RepoModel: Decodable {
    // [df] what if all nil?
    var fullName : String?
    var description: String?
    var owner: Owner?
}

struct Owner: Decodable {
    var avatarUrl : String?
}



//MARK: - FilteredRepos
struct FilteredRepos: Decodable {
    var items: [RepoModel]?
}
