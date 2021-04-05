//
//  ActivityIndicator.swift
//  Eltec_testTask
//
//  Created by Боровик Василий on 05.04.2021.
//

import UIKit

class ActivityIndicator {
	static let shared = ActivityIndicator()
	
	func customActivityIndicatory(_ viewContainer: UIView, startAnimate:Bool? = true) -> UIActivityIndicatorView {
		let mainContainer: UIView = UIView(frame: viewContainer.frame)
		mainContainer.center = viewContainer.center
		mainContainer.backgroundColor = UIColor.black
		mainContainer.alpha = 0.3
		mainContainer.tag = 789456123
		mainContainer.isUserInteractionEnabled = false
		
		let viewBackgroundLoading: UIView = UIView(frame: mainContainer.superview?.frame ?? CGRect(1.1))
		viewBackgroundLoading.center = viewContainer.center
		viewBackgroundLoading.backgroundColor = UIColor.darkGray
		viewBackgroundLoading.alpha = 1
		viewBackgroundLoading.clipsToBounds = true
		viewBackgroundLoading.layer.cornerRadius = 15
		
		let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
		activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
		activityIndicatorView.style = .large
		activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
		if startAnimate!{
			viewBackgroundLoading.addSubview(activityIndicatorView)
			mainContainer.addSubview(viewBackgroundLoading)
			viewContainer.addSubview(mainContainer)
			activityIndicatorView.startAnimating()
		}else{
			for subview in viewContainer.subviews{
				if subview.tag == 789456123{
					subview.removeFromSuperview()
				}
			}
		}
		return activityIndicatorView
	}
	
	private init() { }
}
