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
    var reposListViewModel: ReposListViewModelProtocol?
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupReposListViewModel()
        setupViewController()
        setupSearchController()
        setupTableView()
    }

    
    //MARK: - Methods
    private func setupReposListViewModel() {
        reposListViewModel = ReposListViewModel(){ [unowned self] in
            self.tableView.reloadData()
        }
        reposListViewModel?.errorString.bind(listener: { [unowned self] in
            guard let error = $0 else { return }
            self.popUp(message: error)
        })
        reposListViewModel?.fetchAllRepos()
    }
    
    private func setupViewController() {
        view.backgroundColor = Colors.backGround
        title = Constants.repositories
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapped() {
        guard !tableView.visibleCells.isEmpty else { return }
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
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
        tableView.pin(to: view, with: 5)
        
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.reuseID)
        tableView.dataSource = self
        tableView.allowsSelection = false
    }
}


//MARK: - Extensions

extension ReposViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reposListViewModel?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.reuseID) as? RepoCell
        cell?.viewModel = reposListViewModel?.repoCellViewModel(forIndexPath: indexPath)
        return cell ?? UITableViewCell()
    }
}

extension ReposViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text
        reposListViewModel?.searchTextDidChangeTo(keyword)
    }
}

extension ReposViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let keyword = textField.text
        reposListViewModel?.fetchReposContaining(keyword)
        return true
    }
}
