//
//  QueryServiceObjCWrapper.swift
//  Eltec_testTask
//
//  Created by Боровик Василий on 04.04.2021.
//

import Foundation

@objc(QueryService) public class QueryServiceObjCWrapper: NSObject {
	private let queryService = QueryService()
	
	@objc public func autorization(url: String, login: String, password: String, completion: @escaping (AutorizationResponseClass) -> Void) {
		
		guard let url = URL(string: url) else {
			assertionFailure("URL isn't correct")
			return
		}
		let response = AutorizationResponseClass()
		
		self.queryService.autorization(url: url, login: login, password: password, completion: {
			data, error in
			response.error = error
			if (error == "") {
				response.error = Parsers().JSONParse(data: data, to: &response.data)
			}
			
			completion(response)
		})
	}
}



