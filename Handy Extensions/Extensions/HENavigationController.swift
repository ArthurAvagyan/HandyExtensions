//
//  HENavigationController.swift
//  Handy Extensions
//
//  Created by Arthur Avagyan on 6/15/20.
//

import UIKit

extension UINavigationController {
	
	override open var childForStatusBarHidden: UIViewController? {
        return topViewController
    }
	
	override open var childForStatusBarStyle: UIViewController? {
		return topViewController
	}
	
	func previousViewController() -> UIViewController? {
		guard viewControllers.count > 1 else { return nil }
		return viewControllers[viewControllers.count - 2]
	}
	
	
	/// Pushes view controller safely, so prevents pushing twice
    ///
	///		navigationController?.pushSafely(vc, from: self, animated: true)
    ///
    /// - Parameters:
    ///   - viewController: A view controller to be pushed safey
    ///   - from: The view controller pushing
	///   - animated: Boolean that indicates if push should be animated
    ///
	func pushSafely(_ viewController: UIViewController, from fromVC: UIViewController, animated: Bool) {
		guard topViewController == fromVC else { return }
		pushViewController(viewController, animated: animated)
	}
}
