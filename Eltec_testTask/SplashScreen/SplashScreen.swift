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
		self.navigationController?.setNavigationBarHidden(true, animated: true)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.checkUser()
			self.navigationController?.setNavigationBarHidden(false, animated: true)
		}
	}
	
	private func checkUser() {
		if let userAccount = UserDefaults.standard.object(forKey: userDefaultsKey) as? String {
			
			let userInfo = Locksmith.loadDataForUserAccount(userAccount: userAccount)
			
			if (userInfo?.count != nil) {
				(self.navigationController as? CustomNavigationController)?.showUserInfoScreen(userAccount: userAccount)
				return
			}
		}
		(self.navigationController as? CustomNavigationController)?.showLoginScreen()
	}
}
