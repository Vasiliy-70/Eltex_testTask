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
	
	@IBAction func LogoutAction(_ sender: Any) {
		self.endSession()
	}
	
	private var userAccount: String?
	private var queryService: IQueryService?
	private var url: String?
	private var infoModel = UserInfoModel()
	private let animationDuration: TimeInterval = 1
	
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
		self.showViewElements(false)
		self.loadUserInfo()
		
    }
}

private extension UserInfoScreen {
	func loadUserInfo() {
		guard let urlStr = self.url,
			  let url = URL(string: urlStr) else {
			self.showAlert(message: "Неверный формат URL")
			return
		}
		guard let userAccount = self.userAccount else {
			self.showAlert(message: "Пустое значение аккаунта")
			return
		}
		let userKeys = Locksmith.loadDataForUserAccount(userAccount: userAccount)
		
		guard let token = userKeys?[userAccount] as? String else {
			self.showAlert(message: "Неверный формат токена")
			return
		}
		
		self.queryService?.getUserInfo(url: url, token: token, completion: { data, error in
			var errorDescription = ""
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
				self.showViewElements(true)
			}
		})
	}
	
	func showAlert(message: String) {
		let alert = UIAlertController(title: "Внимание!", message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "Ok", style: .default) {_ in
			self.endSession()
		}
		
		alert.addAction(action)
		self.present(alert, animated: true, completion: nil)
	}
	
	func endSession() {
		UserDefaults.standard.removeObject(forKey: userDefaultsKey)
		(self.navigationController as? RootNavigationController)?.showLoginScreen()
	}
	
	func showViewElements(_ value: Bool) {
		var alpha: CGFloat = 0.0
		var duration: TimeInterval = 0
		
		if (value) {
			alpha = 1
			duration = self.animationDuration
		}
		
		UIView.animate(withDuration: duration) {
			self.permissionTable.alpha = alpha
			self.roleIdLabel.alpha = alpha
			self.usernameLabel.alpha = alpha
			self.emailLabel.alpha = alpha
		}
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
