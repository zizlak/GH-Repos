//
//  RepoModel.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import Foundation

//MARK: - RepoModel
struct RepoModel: Decodable {
    var full_name : String?
    var description: String?
    var owner: Owner?
}

struct Owner: Decodable {
    var avatar_url : String
}



//MARK: - FilteredRepos
struct FilteredRepos: Decodable {
    var items: [RepoModel]?
}
