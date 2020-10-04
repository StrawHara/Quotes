//
//  QuoteCell.swift
//  Quotes
//
//  Created by Romain Le Drogo on 04/10/2020.
//

import UIKit

import Reusable

struct QuoteCellViewModel {
    let body: String
    let id: Int
    let author: String
}

final class QuoteCell: UITableViewCell, Reusable {
    
    // MARK: - Properties
    private var viewModel: QuoteCellViewModel?

    // MARK: - Outlet
    private var bodyLabel: UILabel = {
        let bodyLabel = UILabel()
        bodyLabel.numberOfLines = 0
        bodyLabel.textAlignment = .left
        return bodyLabel
    }()
    private var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.textAlignment = .right
        return authorLabel
    }()

    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: QuoteCellViewModel) {
        self.viewModel = viewModel
        
        self.bodyLabel.text = viewModel.body
        self.authorLabel.text = viewModel.author
    }
    
    // MARK: - Privates
    private func setupUI() {
        self.contentView.addSubviews(self.bodyLabel, self.authorLabel)
        NSLayoutConstraint.activate([
            self.bodyLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.bodyLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.bodyLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),

            self.authorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.authorLabel.topAnchor.constraint(equalTo: self.bodyLabel.bottomAnchor, constant: 20),
            self.authorLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        ])
    }

}
