//
//  LoadingViewController.swift
//  Quotes
//
//  Created by Romain Le Drogo on 28/09/2020.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    // MARK: - Outlets
    private let progressionLabel: UILabel = {
        let progressionLabel = UILabel()
        progressionLabel.translatesAutoresizingMaskIntoConstraints = false
        progressionLabel.text = "Connection in progress..."
        progressionLabel.textAlignment = .center
        progressionLabel.textColor = .white
        return progressionLabel
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        setupUI()
    }
    
    // MARK: - Privates
    private func setupUI() {
        self.view.backgroundColor = .systemGreen
        
        self.view.addSubview(self.progressionLabel)
        NSLayoutConstraint.activate([
            self.progressionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.progressionLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.progressionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 20),
            self.progressionLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.view.trailingAnchor, constant: -20),
        ])
    }
    
}
