//
//  UserInfoModel.swift
//  Eltec_testTask
//
//  Created by Боровик Василий on 04.04.2021.
//

import Foundation

struct UserInfoModel: Codable {
	var roleId: String?
	var username: String?
	var email: String?
	var permissions: [String?]
	
	init() {
		self.roleId = nil
		self.username = nil
		self.email = nil
		self.permissions = [nil]
	}
}


