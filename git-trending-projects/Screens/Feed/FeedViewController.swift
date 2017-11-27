//
//  FeedViewController.swift
//  git-trending-projects
//
//  Created by Argentino Ducret on 11/23/17.
//  Copyright © 2017 wolox. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

class FeedViewController: UIViewController {
    
    private var _view: FeedView { return view as! FeedView }
    private let _viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        _viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = FeedView.loadFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _view.searchBar.delegate = self
        _view.table.delegate = self
        _view.table.dataSource = self
        _view.table.register(UINib(nibName: "FeedCellView", bundle: nil), forCellReuseIdentifier: "FeedCellView")
        bindViewModel()
    }
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource Methods
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let repository = _viewModel[index]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCellView", for: indexPath) as! FeedCellView
        cell.projectDescriptionLabel.text = repository.description
        cell.projectNameLabel.text = repository.fullName
        cell.projectStarsLabel.text = String(repository.stars)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let repository = _viewModel[index]
        let detailViewModel = DetailViewModel(repository: repository)
        let detailController = DetailViewController(viewModel: detailViewModel)
        navigationItem.backBarButtonItem?.title = "Back"
        navigationController?.pushViewController(detailController, animated: true)
    }
    
}

// MARK: - UISearchBarDelegate Methods
extension FeedViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        _viewModel.setSearchBarText(text: searchBar.text ?? "")
    }
    
}

// MARK: - Private Methods
private extension FeedViewController {
    
    func bindViewModel() {
        _viewModel.repositories.signal.observeValues { [unowned self] _ in
            self._view.table.reloadData()
        }
    }
    
}
