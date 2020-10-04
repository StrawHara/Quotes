//
//  ProfileViewController.swift
//  Quotes
//
//  Created by Romain le Drogo on 27/09/2020.
//

import Foundation
import UIKit

import Reusable

final class ProfileViewController: UIViewController, StoryboardBased {
    
    // MARK: - Properties
    // TODO: View model instead of user
    private var user: User? {
        didSet { self.tableView.reloadData() }
    }
    private var networkLayer: NetworkLayer?

    // MARK: - Outlets
    private var tableView: UITableView = UITableView()
    
    // MAKR: Life Cycle
    override func viewDidLoad() {
        
        self.setupUI()

        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.tableView.register(cellType: ImageCell.self)
        self.tableView.register(cellType: UserStatsCell.self)
        
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
        
        self.tableView.reloadData()
    }
    
    func setup(networkLayer: NetworkLayer, user: User? = nil) {
        self.user = user
        self.networkLayer = networkLayer
    }
    
    // MARK: - Privates
    private func setupUI() {
        guard self.user != nil else {return} // TODO: Empty page
        
        self.title = self.user?.login
        
        self.view.addSubviews(tableView)
        self.view.addInFullSize(tableView)
    }
    
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.user != nil else {return 0}
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let user = self.user,
            let networkLayer = self.networkLayer
        else { return UITableViewCell() }

        switch indexPath.row {
        case 0:
            let imageCell = self.tableView.dequeueReusableCell(for: indexPath) as ImageCell
            imageCell.setup(networkLayer: networkLayer, imageURL: user.pictureUrl)
            return imageCell
        case 1:
            let statsCell = self.tableView.dequeueReusableCell(for: indexPath) as UserStatsCell
            statsCell.setup(viewModel: UserStatsCellViewModel(following: user.following, followers: user.followers))
            return statsCell
        default:
            return UITableViewCell()
        }
    }
    
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
}
