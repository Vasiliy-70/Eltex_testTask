//
//  QueryService.swift
//  Eltec_testTask
//
//  Created by Боровик Василий on 03.04.2021.
//

import Foundation
import UIKit

protocol IQueryService: class {
	func getUserInfo(url: URL, token: String, completion: @escaping (Data, String) -> Void)
	func autorization(url: URL, login: String, password: String, completion: @escaping (Data, String) -> Void)
}

final class QueryService: IQueryService {

	private let defaultSession = URLSession(configuration: .default)
	private var dataTask: URLSessionDataTask?
	private var errorMessage = ""
	private var responseData = Data()
	
	typealias QueryResult = (Data, String) -> Void

	func getUserInfo(url: URL, token: String, completion: @escaping QueryResult) {
		self.dataTask?.cancel()
		
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
		self.dataTask = defaultSession.dataTask(with: request) { [weak self] data, response, error in
			defer {
				self?.dataTask = nil
			}
			
			self?.responseData = Data()
			self?.errorMessage = ""
			
			if let error = error {
				self?.errorMessage = "Ошибка обновления данных: \(error.localizedDescription)\n"
			} else if let data = data,
					  let response = response as? HTTPURLResponse {
				print(token)
				print(response.statusCode)
				if response.statusCode == 200 {
					self?.responseData = data
				} else {
					self?.errorMessage = "Ошибка обновления данных.Код:  \(response.statusCode)"
				}
			}
			
			DispatchQueue.main.async {
				completion(self?.responseData ?? Data(), self?.errorMessage ?? "")
			}
		}
		self.dataTask?.resume()
	}
	
	func autorization(url: URL, login: String, password: String, completion: @escaping (Data, String) -> Void) {
		self.dataTask?.cancel()

		var authorizationHeader = ""
		let credentials = "ios-client:password".data(using: .utf8)
		if let base64Encoded = credentials?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) {
			authorizationHeader = base64Encoded
		}
		let parameters = "grant_type=password&username=\(login)&password=\(password)"
		let httpBody = parameters.data(using: .ascii, allowLossyConversion: true)
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("Basic " + authorizationHeader, forHTTPHeaderField: "Authorization")
		request.httpBody = httpBody
		
		let response = defaultSession.synchronousDataTask(with: request)
		
		if let error = response.2 {
			self.errorMessage = "Ошибка при попытке авторизации: \(error.localizedDescription)\n"
		} else if let data = response.0,
				  let response = response.1 as? HTTPURLResponse {
			if response.statusCode == 200 {
				self.responseData = data
			} else {
				self.errorMessage = "Ошибка при попытке авторизации. Код: \(response.statusCode)"
			}
		}
		
		completion(self.responseData, self.errorMessage)
	}
}
