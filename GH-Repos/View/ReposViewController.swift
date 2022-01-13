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
        repoListViewModel?.errorString.bind(listener: { [unowned self] in
            guard let error = $0 else { return }
            self.popUp(message: error)
        })
        repoListViewModel?.fetchAllRepos()
    }
    
    private func setupViewController() {
        view.backgroundColor = Colors.backGround
        title = "Repositories"
    }
    
    private func setupSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search repositories"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        tableView.backgroundColor = Colors.backGround
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
        repoListViewModel?.searchTextDidChange(to: keyword)
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
        guard let keyword = textField.text else { return false }
        repoListViewModel?.fetchReposContaining(keyword)
        return true
    }
}
