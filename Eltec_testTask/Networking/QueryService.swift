//
//  QueryService.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 16.01.2020.
//

import Foundation
import UIKit

protocol IQueryService: class {
	func getDataAt(url: URL, completion: @escaping (Data, String) -> Void)
	func autorization()
}

@objc class QueryService: NSObject, IQueryService {
	private let defaultSession = URLSession(configuration: .default)
	private var dataTask: URLSessionDataTask?
	private var errorMessage = ""
	private var responseData = Data()
	
	typealias QueryResult = (Data, String) -> Void
	
	func getDataAt(url: URL, completion: @escaping QueryResult) {
		self.dataTask?.cancel()

		self.dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
			defer {
				self?.dataTask = nil
			}
			
			self?.responseData = Data()
			self?.errorMessage = ""
			
			if let error = error {
				self?.errorMessage = "Data task error: \(error.localizedDescription)\n"
			} else if let data = data,
					  let response = response as? HTTPURLResponse {
				if response.statusCode == 200 {
					self?.responseData = data
				} else {
					self?.errorMessage = "Data task error: code \(response.statusCode)\n"
				}
			}
			
			DispatchQueue.global(qos: .userInitiated).async {
				completion(self?.responseData ?? Data(), self?.errorMessage ?? "")
			}
		}
		self.dataTask?.resume()
	}
	
	@objc func autorization() {
		var authorizationHeader = "";
		if let url = URL(string: "http://smart.eltex-co.ru:8271/api/v1/oauth/token") {
//		   let authorizationHeader = "ios-client:<borovik>".data(using: .utf8)?.base64EncodedString() {
			
			let str = "ios-client:password"
			print("Original: \(str)")

			let utf8str = str.data(using: .utf8)

			if let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) {
				print("Encoded: \(base64Encoded)")
				
				authorizationHeader = base64Encoded
			}
			
			
			var request = URLRequest(url: url)
			request.httpMethod = "POST"
			request.setValue("Basic " + authorizationHeader, forHTTPHeaderField: "Authorization")
			

			let parameters = [
				"grant_type":"password",
				"username":"borovik",
				"password":"borovik"
			]
			do {
			request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
			} catch {
				
			}
			print(request.httpBody)
			self.dataTask = defaultSession.dataTask(with: request) { data, response, error in
				guard let data = data else { return }
//				print(self.JSONParse(data: data).1)
				print(response)
				print(self.JSONParse(data: data).0)
			}

			}
			self.dataTask?.resume()
				
			}
	
	func JSONParse(data: Data) -> (testStruct, String) {
		var errorDescription = ""
		var entityModel = testStruct()
		
		do {
			entityModel = try JSONDecoder().decode(testStruct.self,
												   from: data)
		} catch let error {
			errorDescription = error.localizedDescription
		}
		
		return (entityModel, errorDescription)
	}
	
	@objc func login(user: String, password: String) {
		print("user \(user), password: \(password)")
		autorization()
	}
}

struct testStruct: Codable {
	var access_token: String?
	var token_type: String?
	var refresh_token: String?
	var expires_in: Int?
	var scope: String?
}
