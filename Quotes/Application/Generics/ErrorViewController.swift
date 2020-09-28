//
//  ErrorViewController.swift
//  Quotes
//
//  Created by Romain Le Drogo on 28/09/2020.
//

import UIKit

final class ErrorViewController: UIViewController {
    
    // MARK: Properties
    private var delegate: AppCoordinatorErrorDelegate?
    
    // MARK: - Outlets
    private let errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.textAlignment = .center
        errorLabel.textColor = .white
        return errorLabel
    }()

    private let retryButton: UIButton = {
        let retryButton = UIButton()
        retryButton.setTitle("Retry", for: .normal)
        retryButton.contentHorizontalAlignment = .center
        return retryButton
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        setupUI()
    }
    
    func setup(error: Error?, delegate: AppCoordinatorErrorDelegate?) {
        self.delegate = delegate
        
        guard let error = error as? NetworkError else {
            errorLabel.text = "Unknnow error, please try again later"
            return
        }
        errorLabel.text = error.description
    }

    // MARK: - Privates
    private func setupUI() {
        self.view.backgroundColor = .systemRed
        
        self.view.addSubviews(self.errorLabel, self.retryButton)
        NSLayoutConstraint.activate([
            self.errorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.errorLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.errorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.errorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),

            self.retryButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.retryButton.topAnchor.constraint(greaterThanOrEqualTo: self.errorLabel.bottomAnchor, constant: 20),
            self.retryButton.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 20),
            self.retryButton.trailingAnchor.constraint(greaterThanOrEqualTo: self.view.trailingAnchor, constant: -20),
            self.retryButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20)
        ])
        
        self.retryButton.addTarget(self, action: #selector(retry), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func retry() {
        self.delegate?.retry()
    }
    
}
