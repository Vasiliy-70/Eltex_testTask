//
//  AutorizationResponse.swift
//  Eltec_testTask
//
//  Created by Боровик Василий on 04.04.2021.
//

import Foundation

struct AutorizationResponse: Codable {
	var access_token: String?
	var token_type: String?
	var refresh_token: String?
	var expires_in: Int?
	var scope: String?
}

@objc public class AutorizationResponseClass: NSObject {
	private override init() {
		if self.data == nil {
			self.data = AutorizationResponse()
		}
	}
	private static var uniqueInstance: AutorizationResponseClass?
	
	var data: AutorizationResponse?
	var error = ""
	
	@objc static func shared() -> AutorizationResponseClass {
		if self.uniqueInstance == nil {
			self.uniqueInstance = AutorizationResponseClass()
		}
		return uniqueInstance!
	}
	
	@objc func getError() -> String { return self.error}
	@objc func getAccessToken() -> String? { return self.data?.access_token}
}
