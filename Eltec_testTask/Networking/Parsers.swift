//
//  Parsers.swift
//  Eltec_testTask
//
//  Created by Боровик Василий on 04.04.2021.
//

import Foundation

final class Parsers {
	func JSONParse<AnyStruct: Codable>(data: Data, to model: inout AnyStruct) -> String {
		var errorDescription = ""
		
		do {
			model = try JSONDecoder().decode(AnyStruct.self,
										 from: data)
		} catch let error {
			errorDescription = error.localizedDescription
		}
		
		return errorDescription
	}
}
