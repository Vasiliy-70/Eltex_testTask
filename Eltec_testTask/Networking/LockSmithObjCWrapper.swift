//
//  LockSmithObjCWrapper.swift
//  Eltec_testTask
//
//  Created by Боровик Василий on 04.04.2021.
//

import Foundation
import Locksmith

@objc public class LocksmithObjCWrapper: NSObject {
	@objc(saveDatawithkey:value:forUserAccount:error:) public func saveData(key: String, value: String, forUserAccount: String) throws {
		do {
			try Locksmith.saveData(data: [key: value], forUserAccount: forUserAccount)
			UserDefaults.standard.setValue(forUserAccount, forKey: userDefaultsKey)
		} catch LocksmithError.duplicate {
			try Locksmith.updateData(data: [key: value], forUserAccount: forUserAccount)
			UserDefaults.standard.setValue(forUserAccount, forKey: userDefaultsKey)
		} catch let error{
			throw error
		}
	}
}
