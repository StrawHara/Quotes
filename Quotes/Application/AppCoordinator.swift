//
//  AppCoordinator.swift
//  Quotes
//
//  Created by Romain le Drogo on 27/09/2020.
//

import Foundation
import UIKit

import Reusable

final class AppCoordinator: NSObject {
    
    private enum TabbarItem: Int {
        case quotes = 0
        case profile
    }
    
    private var window: UIWindow?
    
    private var tabbarController: UITabBarController?
    
    private var quotesNav: UINavigationController?
    private var quotesVC: QuotesViewController?
    
    private var profileNav: UINavigationController?
    private var profileVC: ProfileViewController?
    
    private var errorVC: ErrorViewController?

    private var loadingVC: LoadingViewController?
    
    // MARK: Life cycle
    init(window: UIWindow?) {
        self.window = window
    }
    
    // MARK: Coordinator implementation
    func start() {
        self.connect()
    }
    
    // MARK: Privates
    private func connect() {
        self.showLoadingScreen()
        NetworkLayer.shared.execute(Session.SessionRouter.login(login: "strawhara", password: "plop42")) { (result: Result<Session, Error>) in
            switch result {
            case .success(let session):
                DispatchQueue.main.async { self.showAppContent() }
                print(session)
            case .failure(let error):
                DispatchQueue.main.async { self.showErrorScreen(error: error) }
            }
        }
    }
}

// MARK: - Loading
extension AppCoordinator {
    
    private func showLoadingScreen() {
        self.loadingVC = LoadingViewController()
        self.window?.rootViewController = self.loadingVC
    }
    
}

// MARK: - Error
protocol AppCoordinatorErrorDelegate {
    func retry()
}

extension AppCoordinator: AppCoordinatorErrorDelegate {
    
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
extension AppCoordinator {
    
    // TODO: Instantiate new coordinator instead
    private func showAppContent() {
        // MARK: Navigation Controllers
        let quotesVC = QuotesViewController.instantiate()
        let quotesNav = UINavigationController(rootViewController: quotesVC)
        quotesNav.tabBarItem = UITabBarItem(title: "Quotes",
                                            image: UIImage(systemName: "quote.bubble.fill"),
                                            tag: TabbarItem.quotes.rawValue)
        self.quotesVC = quotesVC; self.quotesNav = quotesNav

        let profileVC = ProfileViewController.instantiate()
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile",
                                             image: UIImage(systemName: "person.fill"),
                                             tag: TabbarItem.profile.rawValue)
        self.profileVC = profileVC; self.profileNav = profileNav

        // MARK: Tabbar
        self.tabbarController = UITabBarController()
        self.tabbarController?.viewControllers = [quotesNav, profileNav]
        self.tabbarController?.tabBar.contentMode = .scaleAspectFill
        self.tabbarController?.tabBar.clipsToBounds = false
        
        self.window?.rootViewController = self.tabbarController
    }
    
}
