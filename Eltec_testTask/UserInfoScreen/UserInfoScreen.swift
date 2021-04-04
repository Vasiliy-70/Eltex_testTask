//
//  UserInfoScreen.swift
//  Eltec_testTask
//
//  Created by Боровик Василий on 03.04.2021.
//

import UIKit
import Locksmith

final class UserInfoScreen: UIViewController {
	@IBOutlet weak var roleIdLabel: UILabel!
	@IBOutlet weak var usernameLabel: UILabel!
	@IBOutlet weak var emailLabel: UILabel!
	@IBOutlet weak var permissionTable: UITableView!
	
	private var userAccount: String?
	private var queryService: IQueryService?
	private var url: String?
	private var infoModel = UserInfoModel()
	@IBAction func LogoutAction(_ sender: Any) {
		(self.navigationController as? CustomNavigationController)?.showLoginScreen()
		UserDefaults.standard.removeObject(forKey: userDefaultsKey)
	}
	
	static func storyboardInstance(userAccount: String, queryService: IQueryService, url: String) -> UserInfoScreen? {
		let storyboard = UIStoryboard(name:String(describing: self), bundle: nil)
		let screen = storyboard.instantiateInitialViewController() as? UserInfoScreen
		screen?.userAccount = userAccount
		screen?.queryService = queryService
		screen?.url = url
		return screen
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.loadUserInfo()
    }
}

private extension UserInfoScreen {
	func loadUserInfo() {
		var errorDescription = ""
		guard let urlStr = self.url,
			  let url = URL(string: urlStr) else {
			errorDescription = "Неверный формат URL"
			return
		}
		guard let userAccount = self.userAccount else {
			errorDescription = "Пустое значение аккаунта"
			return
		}
		let userKeys = Locksmith.loadDataForUserAccount(userAccount: userAccount)
		
		guard let token = userKeys?[userAccount] as? String else {
			errorDescription = "Неверный формат токена"
			return
		}
		
		self.queryService?.getUserInfo(url: url, token: token, completion: { data, error in
			if error == "" {
				errorDescription = Parsers().JSONParse(data: data, to: &self.infoModel)
			} else {
				errorDescription = error
			}
			
			if (errorDescription != "") {
				self.showAlert(message: errorDescription)
			} else {
				self.roleIdLabel.text = self.infoModel.roleId
				self.usernameLabel.text = self.infoModel.username
				self.emailLabel.text = self.infoModel.email
				self.permissionTable.reloadData()
			}
		})
	}
	
	func showAlert(message: String) {
		let alert = UIAlertController(title: "Внимание!", message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
		alert.addAction(action)
		self.present(alert, animated: true, completion: nil)
	}
}

// MARK: UITableViewDelegate

extension UserInfoScreen: UITableViewDelegate {
	
}

// MARK: UITableViewDataSource

extension UserInfoScreen: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.infoModel.permissions.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellId") else {
			assertionFailure("No cell")
			return UITableViewCell()
		}
		
		cell.textLabel?.text = self.infoModel.permissions[indexPath.row]
		return cell
	}
}
