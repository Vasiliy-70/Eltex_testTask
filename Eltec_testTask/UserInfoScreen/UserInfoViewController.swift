//
//  UserInfoViewController.swift
//  Eltec_testTask
//
//  Created by Боровик Василий on 03.04.2021.
//

import UIKit

final class UserInfoViewController: UIViewController {
	private var test = ["1", "2", "3", "4"]

	static func storyboardInstance() -> UserInfoViewController? {
		let storyboard = UIStoryboard(name:String(describing: self), bundle: nil)
		return storyboard.instantiateInitialViewController() as? UserInfoViewController
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

// MARK: UITableViewDelegate

extension UserInfoViewController: UITableViewDelegate {
	
}

// MARK: UITableViewDataSource

extension UserInfoViewController: UITableViewDataSource {
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
