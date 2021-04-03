//
//  SplashScreen.swift
//  Eltec_testTask
//
//  Created by Боровик Василий on 03.04.2021.
//

import UIKit

class SplashScreen: UIViewController {
	static func storyboardInstance() -> SplashScreen? {
		let storyboard = UIStoryboard(name:String(describing: self), bundle: nil)
		return storyboard.instantiateInitialViewController() as? SplashScreen
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.setNavigationBarHidden(true, animated: true)
		let loginScreen = LoginScreen.storyboardInstance()
		let userInfoScreen = UserInfoScreen.storyboardInstance() ?? UserInfoScreen()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//			self.navigationController?.viewControllers = [loginScreen]
			self.navigationController?.setViewControllers([userInfoScreen], animated: true)
			self.navigationController?.setNavigationBarHidden(false, animated: true)
		}
    }
}
