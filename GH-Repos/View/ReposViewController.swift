//
//  ReposViewController.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 12.01.22.
//

import UIKit

class ReposViewController: UIViewController {

    //MARK: - Interface
    private let tableView = UITableView()
    
    //MARK: - Properties
    
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupSearchController()
        setupTableView()
        
        DataFetcherService().fetchReposBy(keyword: "Zoom") { result in
            switch result {
                
            case .success(let repos):
                print(repos.items![3].owner?.avatar_url)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    
    //MARK: - Methods
    
    private func setupViewController() {
        view.backgroundColor = Colors.second
        title = "Repositories"
    }
    
    private func setupSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search repositories"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        tableView.backgroundColor = Colors.second
        tableView.pin(to: view)
        
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.reuseID)
        tableView.dataSource = self
    }
}


//MARK: - Extensions

extension ReposViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let keyword = searchController.searchBar.text else { return }
        if keyword.isEmpty {
            print("Empty")
        }
        print(keyword)
    }
    
    
}

extension ReposViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        22
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.reuseID) as? RepoCell
        
        cell?.nameLabel.text = "RRR"
        cell?.descriptionLabel.text = "Description scription Description Description DescriptionDescription Description Description DescriptionDescription scription Description Description DescriptionD Description"
        cell?.avatarView.image = UIImage(systemName: "hare")
        return cell ?? UITableViewCell()
    }
}
