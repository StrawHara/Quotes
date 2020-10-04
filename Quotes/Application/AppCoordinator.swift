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
    private var networkLayer: NetworkLayer

    private var tabbarController: UITabBarController?
    
    private var quotesNav: UINavigationController?
    private var quotesVC: QuotesViewController?
    
    private var profileNav: UINavigationController?
    private var profileVC: ProfileViewController?

    // MARK: Life cycle
    init(window: UIWindow?, networkLayer: NetworkLayer) {
        self.window = window
        self.networkLayer = networkLayer
    }
    
    // MARK: Coordinator implementation
    func start() {
        // MARK: Navigation Controllers
        let quotesVC = QuotesViewController.instantiate()
        let quotesNav = UINavigationController(rootViewController: quotesVC)
        quotesNav.tabBarItem = UITabBarItem(title: "Quotes",
                                            image: UIImage(systemName: "quote.bubble.fill"),
                                            tag: TabbarItem.quotes.rawValue)
        self.quotesVC = quotesVC; self.quotesNav = quotesNav

        let profileVC = ProfileViewController.instantiate()
        profileVC.setup(networkLayer: self.networkLayer)
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
        
        self.getUser()
        self.getQuotes()
    }
    
    // MARK: Privates
    private func getUser() {
        self.networkLayer.execute(User.UserRouter.get(login: "strawhara")) { (result: Result<User, Error>) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.profileVC?.setup(networkLayer: self.networkLayer, user: user) }
                print(user)
            case .failure(let error):
                print((error as? NetworkError)?.debug ?? "")
                break
            }
        }
    }
    
    private func getQuotes() {
        self.networkLayer.execute(QuotePage.QuotePageRouter.any) { (result: Result<QuotePage, Error>) in
            switch result {
            case .success(let quotePage):
                DispatchQueue.main.async { self.quotesVC?.setup(quotes: quotePage.quotes) }
            case .failure(let error):
                print((error as? NetworkError)?.debug ?? "")
                break
            }
        }
    }

}
