//
//  DetailViewController.swift
//  git-trending-projects
//
//  Created by Argentino Ducret on 11/27/17.
//  Copyright © 2017 wolox. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    private var _view: DetailView { return view as! DetailView }
    private let _viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        _viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = DetailView.loadFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        bindViewModel()
    }
    
}

// MARK: - Private Methods
private extension DetailViewController {
    
    func setNavigationAppereance() {
        navigationController?.navigationBar.tintColor = UIColor.black
        title = _viewModel.title
    }
    
    func initializeView() {
        setNavigationAppereance()
        initializeTexts()
        initializeAvatar()
    }
    
    func initializeTexts() {
        _view.username.text = _viewModel.username
        _view.projectDescription.text = _viewModel.description
        _view.forks.text = _viewModel.forks
        _view.stars.text = _viewModel.stars
    }
    
    func initializeAvatar() {
        let avatarURL = _viewModel.avatarURL
        _view.avatar.loadContentFromURL(imageURL: avatarURL)
        _view.avatar.layer.masksToBounds = false
        _view.avatar.layer.cornerRadius = _view.avatar.frame.height / 2
        _view.avatar.clipsToBounds = true
    }
    
    func bindViewModel() {
        _viewModel.readme.signal.observeValues { [unowned self] readme in
            self._view.readme.text = readme
        }
    }
    
}
