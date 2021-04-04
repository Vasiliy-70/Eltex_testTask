//
//  CustomNavigationController.swift
//  Eltec_testTask
//
//  Created by Боровик Василий on 04.04.2021.
//

import UIKit

protocol ICustomNavigationController: class {
	func showLoginScreen()
	func showUserInfoScreen(userAccount: String)
}

final class CustomNavigationController: UINavigationController {
	private let queryService = QueryService()
	private let urlAutorization = "http://smart.eltex-co.ru:8271/api/v1/oauth/token"
	private let urlGetInfo = "http://smart.eltex-co.ru:8271/api/v1/user"
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: ICustomNavigationController

@objc extension CustomNavigationController: ICustomNavigationController {
	@objc func showLoginScreen() {
		let loginScreen = LoginScreen.storyboardInstance(urlAutorization)
		self.setViewControllers([loginScreen], animated: true)
	}
	
	@objc func showUserInfoScreen(userAccount: String) {
		if let userInfoScreen = UserInfoScreen.storyboardInstance(userAccount: userAccount, queryService: self.queryService, url: self.urlGetInfo) {
			self.setViewControllers([userInfoScreen], animated: true)
		}
	}
	
	
}
