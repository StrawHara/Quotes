//
//  QuotesViewController.swift
//  Quotes
//
//  Created by Romain le Drogo on 27/09/2020.
//

import UIKit

import Reusable

final class QuotesViewController: UIViewController, StoryboardBased {
    
    // MARK: - Properties
    // TODO: View model instead of user
    private var quotes: [Quote] = [] {
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

        self.tableView.register(cellType: QuoteCell.self)
        
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
        
        self.tableView.reloadData()
    }
    
    func setup(quotes: [Quote]) {
        self.quotes = quotes
    }
    
    // MARK: - Privates
    private func setupUI() {
        self.title = "Quotes"
        
        self.view.addSubviews(tableView)
        self.view.addInFullSize(tableView)
    }
    
}

// MARK: - UITableViewDataSource
extension QuotesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quote = quotes[indexPath.row]
        let quoteCell = self.tableView.dequeueReusableCell(for: indexPath) as QuoteCell
        quoteCell.setup(viewModel: QuoteCellViewModel(body: quote.body, id: quote.id, author: quote.author))
        return quoteCell
    }
    
}

// MARK: - UITableViewDelegate
extension QuotesViewController: UITableViewDelegate {
    
}
