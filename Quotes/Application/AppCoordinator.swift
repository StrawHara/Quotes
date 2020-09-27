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

  private var tabbarController: UITabBarController

  private var quotesNav: UINavigationController
  private var quotesVC: QuotesViewController

  private var profileNav: UINavigationController
  private var profileVC: ProfileViewController

  init(window: UIWindow?) {
    self.window = window

    // MARK: Navigation Controllers
    self.quotesVC = QuotesViewController.instantiate()
    self.quotesNav = UINavigationController(rootViewController: self.quotesVC)
    self.quotesNav.tabBarItem = UITabBarItem(title: "Quotes",
                                             image: UIImage(systemName: "quote.bubble.fill"),
                                             tag: TabbarItem.quotes.rawValue)

    self.profileVC = ProfileViewController.instantiate()
    self.profileNav = UINavigationController(rootViewController: self.profileVC)
    self.profileNav.tabBarItem = UITabBarItem(title: "Profile",
                                              image: UIImage(systemName: "person.fill"),
                                              tag: TabbarItem.profile.rawValue)

    // MARK: Tabbar
    self.tabbarController = UITabBarController()
    self.tabbarController.viewControllers = [quotesNav, profileNav]
    self.tabbarController.tabBar.contentMode = .scaleAspectFill
    self.tabbarController.tabBar.clipsToBounds = false

    self.window?.rootViewController = self.tabbarController
  }

  // MARK: Coordinator implementation
  func start() {

  }

}
