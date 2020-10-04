//
//  ImageCell.swift
//  Quotes
//
//  Created by Romain Le Drogo on 28/09/2020.
//

import UIKit

import Reusable

final class ImageCell: UITableViewCell, Reusable {
    
    // MARK: - Properties
    private var networkLayer: NetworkLayer?
    private var imageURL: URL?

    // MARK: - Outlet
    private var contentImageView: UIImageView = {
        let contentImageView = UIImageView()
        contentImageView.contentMode = .scaleAspectFit
        contentImageView.layer.cornerRadius = contentImageView.bounds.height / 2
        return contentImageView
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(networkLayer: NetworkLayer, imageURL: String) {
        self.networkLayer = networkLayer
        
        guard let imageURL = URL(string: imageURL) else {return}
        self.imageURL = imageURL

        self.setup(networkLayer: networkLayer, imageURL: imageURL)
    }

    func setup(networkLayer: NetworkLayer, imageURL: URL) {
        networkLayer.getData(from: imageURL, completion: { (result: Result<UIImage, Error>) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async { self.contentImageView.image = image }
            case .failure(let error):
                print((error as? NetworkError)?.description ?? "")
                DispatchQueue.main.async { self.contentImageView.image = UIImage(systemName: "person.fill") }
            }
        })
    }
    
    // MARK: - Privates
    private func setupUI() {
        self.contentView.addSubviews(self.contentImageView)
        NSLayoutConstraint.activate([
            self.contentImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.contentImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.contentImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: 20),
            self.contentImageView.trailingAnchor.constraint(greaterThanOrEqualTo: self.contentView.trailingAnchor, constant: -20),
            self.contentImageView.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor, constant: 20),
            self.contentImageView.bottomAnchor.constraint(greaterThanOrEqualTo: self.contentView.bottomAnchor, constant: -20),
            self.contentImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

}
