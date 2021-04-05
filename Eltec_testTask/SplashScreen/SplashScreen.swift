//
//  SplashScreen.swift
//  Eltec_testTask
//
//  Created by Боровик Василий on 03.04.2021.
//

import UIKit
import Locksmith

final class SplashScreen: UIViewController {
	private var queryService: IQueryService?
	
	static func storyboardInstance(queryService: IQueryService) -> SplashScreen? {
		let storyboard = UIStoryboard(name:String(describing: self), bundle: nil)
		let splashScreen = storyboard.instantiateInitialViewController() as? SplashScreen
		splashScreen?.queryService = queryService
		return splashScreen
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.checkSession()
	}
	
//	Проверка, есть ли сохранённая пользовательская сессия
	private func checkSession() {
		if let userAccount = UserDefaults.standard.object(forKey: userDefaultsKey) as? String {
			let userInfo = Locksmith.loadDataForUserAccount(userAccount: userAccount)
			
			if (userInfo?.count != nil) {
				(self.navigationController as? RootNavigationController)?.showUserInfoScreen(userAccount: userAccount)
				return
			}
		}
		(self.navigationController as? RootNavigationController)?.showLoginScreen()
	}
}
