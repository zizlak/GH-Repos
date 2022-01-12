//
//  ReposViewController.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import UIKit

class ReposViewController: UIViewController {

    //MARK: - Interface
    
    
    //MARK: - Properties
    
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        DataFetcherService().fetchRepos { result in
            switch result {
                
            case .success(let repos):
                print(repos[12].owner?.avatar_url)
            case .failure(_):
                break
            }
        }
    }
    
    
    //MARK: - Methods
    
    
    //MARK: - Extensions



}

