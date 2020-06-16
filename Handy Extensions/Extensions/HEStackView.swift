//
//  HEStackView.swift
//  Handy Extensions
//
//  Created by Arthur Avagyan on 6/15/20.
//

import UIKit

extension UIStackView {
	
	func removeAllArrangedSubviews() {
		for arrangedSubview in arrangedSubviews {
			arrangedSubview.removeFromSuperview()
			removeArrangedSubview(arrangedSubview)
		}
	}
}
