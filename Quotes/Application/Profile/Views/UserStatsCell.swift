//
//  UserStatsCell.swift
//  Quotes
//
//  Created by Romain Le Drogo on 04/10/2020.
//

import UIKit

import Reusable

struct UserStatsCellViewModel {
    let following: Int
    let followers: Int
}

final class UserStatsCell: UITableViewCell, Reusable {
    
    // MARK: - Properties
    private var viewModel: UserStatsCellViewModel?

    // MARK: - Outlet
    private var statsStackView: UIStackView = {
        let statsStackView = UIStackView()
        statsStackView.distribution = .fillEqually
        statsStackView.contentMode = .center
        statsStackView.spacing = 20
        return statsStackView
    }()

    private var followingLabel: UILabel = {
        let followingLabel = UILabel()
        followingLabel.textAlignment = .center
        return followingLabel
    }()
    private var followersLabel: UILabel = {
        let followersLabel = UILabel()
        followersLabel.textAlignment = .center
        return followersLabel
    }()

    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: UserStatsCellViewModel) {
        self.viewModel = viewModel
        
        self.followersLabel.text = "Followers: \(viewModel.followers)"
        self.followingLabel.text = "Following: \(viewModel.following)"
    }
    
    // MARK: - Privates
    private func setupUI() {
        self.contentView.addSubviews(self.statsStackView)
        NSLayoutConstraint.activate([
            self.statsStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.statsStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            self.statsStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.statsStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
        ])

        self.statsStackView.addArrangedSubview(self.followingLabel)
        self.statsStackView.addArrangedSubview(self.followersLabel)

    }

}
