//
//  UserInfoScreen.swift
//  Eltec_testTask
//
//  Created by Боровик Василий on 03.04.2021.
//

import UIKit

final class UserInfoScreen: UIViewController {
	private var test = ["1", "2", "3", "4"]

	@IBAction func LogoutAction(_ sender: Any) {
		let loginScreen = LoginScreen.storyboardInstance()
		self.navigationController?.setViewControllers([loginScreen], animated: true)
	}
	
	static func storyboardInstance() -> UserInfoScreen? {
		let storyboard = UIStoryboard(name:String(describing: self), bundle: nil)
		return storyboard.instantiateInitialViewController() as? UserInfoScreen
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

// MARK: UITableViewDelegate

extension UserInfoScreen: UITableViewDelegate {
	
}

// MARK: UITableViewDataSource

extension UserInfoScreen: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return test.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellId") else {
			assertionFailure("No cell")
			return UITableViewCell()
		}
		
		cell.textLabel?.text = test[indexPath.row]
		return cell
	}
}
