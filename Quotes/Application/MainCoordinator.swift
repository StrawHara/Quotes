//
//  MainCoordinator.swift
//  Quotes
//
//  Created by Romain Le Drogo on 28/09/2020.
//

import Foundation
import UIKit

import Reusable

final class MainCoordinator: NSObject {
    
    private var window: UIWindow?

    private var errorVC: ErrorViewController?
    private var loadingVC: LoadingViewController?
    
    private var appCoordinator: AppCoordinator?
    
    private var networkLayer: NetworkLayer?
    
    // MARK: Life cycle
    init(window: UIWindow?) {
        self.window = window

        super.init()

        self.networkLayer = NetworkLayer(delegate: self)
    }
    
    // MARK: Coordinator implementation
    func start() {
        // TODO: Try to get access token from Keychain
        self.connect()
    }
    
    // MARK: Privates
    private func connect() {
        // TODO: present Login ViewController
        // Add completion handler and then try to connect with completion
        self.showLoadingScreen()
        self.networkLayer?.execute(Session.SessionRouter.login(login: "strawhara", password: "plop42")) { (result: Result<Session, Error>) in
            switch result {
            case .success(let session):
                self.networkLayer?.accesToken = session.userToken
                DispatchQueue.main.async { self.showAppContent() }
                print(session)
            case .failure(let error):
                DispatchQueue.main.async { self.showErrorScreen(error: error) }
            }
        }
    }
}

// MARK: - Loading
extension MainCoordinator {
    
    private func showLoadingScreen() {
        self.loadingVC = LoadingViewController()
        self.window?.rootViewController = self.loadingVC
    }
    
}

// MARK: - ErrorViewControllerDelegate
extension MainCoordinator: ErrorViewControllerDelegate {
    
    private func showErrorScreen(error: Error?) {
        self.errorVC = ErrorViewController()
        self.errorVC?.setup(error: error, delegate: self)
        self.window?.rootViewController = self.errorVC
    }
    
    func retry() {
        self.connect()
    }
    
}

// MARK: - Success
extension MainCoordinator {
    
    private func showAppContent() {
        guard let networkLayer = self.networkLayer else {
            self.showErrorScreen(error: NetworkError.networkLayerDown)
            return
        }
        self.appCoordinator = AppCoordinator(window: self.window, networkLayer: networkLayer)
        self.appCoordinator?.start()
    }
    
}

// MARK: - NetworkLayerDelegate
extension MainCoordinator: NetworkLayerDelegate {

    func didDisconnect() {
        self.connect()
    }
    
}
