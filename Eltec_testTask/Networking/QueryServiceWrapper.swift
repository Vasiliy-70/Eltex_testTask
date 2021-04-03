//
//  QueryServiceWrapper.swift
//  Eltec_testTask
//
//  Created by Боровик Василий on 01.04.2021.
//

import Foundation

@objc(QueryService)
final class QueryServiceWrapper: NSObject {
	
	private let queryService: IQueryService
	
	init(queryService: IQueryService) {
		self.queryService = queryService
	}
	
	@objc
	public func autorization() {
		self.queryService.autorization()
	}
}
