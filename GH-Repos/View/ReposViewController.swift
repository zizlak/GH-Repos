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
    var repoListViewModel: RepoListViewModelProtocol?
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRepoListViewModel()
        setupViewController()
        setupSearchController()
        setupTableView()
    }
    
    
    //MARK: - Methods
    private func setupRepoListViewModel() {
        repoListViewModel = RepoListViewModel(){ [unowned self] in
            self.tableView.reloadData()
        }
        repoListViewModel?.fetchStories()
    }
    
    private func setupViewController() {
        view.backgroundColor = Colors.second
        title = "Repositories"
    }
    
    private func setupSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search repositories"
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.searchTextField.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        tableView.backgroundColor = Colors.second
        tableView.pin(to: view)
        
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.reuseID)
        tableView.dataSource = self
        tableView.allowsSelection = false
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
        repoListViewModel?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.reuseID) as? RepoCell
        cell?.viewModel = repoListViewModel?.repoCellViewModel(forIndexPath: indexPath)
        return cell ?? UITableViewCell()
    }
}


extension ReposViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Suchen")
        return true
    }
}
