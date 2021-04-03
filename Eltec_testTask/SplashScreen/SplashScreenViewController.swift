//
//  SplashScreenViewController.swift
//  Eltec_testTask
//
//  Created by Боровик Василий on 03.04.2021.
//

import UIKit

class SplashScreenViewController: UIViewController {
	static func storyboardInstance() -> SplashScreenViewController? {
		let storyboard = UIStoryboard(name:String(describing: self), bundle: nil)
		return storyboard.instantiateInitialViewController() as? SplashScreenViewController
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let nv = LoginViewController.storyboardInstance()
		let nv2 = UserInfoViewController.storyboardInstance() ?? UserInfoViewController()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//			self.navigationController?.viewControllers = [nv]
			self.navigationController?.viewControllers = [nv2]
		}
    }
}
