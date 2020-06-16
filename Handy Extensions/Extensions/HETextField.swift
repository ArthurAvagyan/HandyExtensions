//
//  HETextField.swift
//  Handy Extensions
//
//  Created by Arthur Avagyan on 6/15/20.
//

import UIKit

extension UITextField {
	
	func addShowHideButtonWith(_ image: UIImage, inactiveImage: UIImage) {
		isSecureTextEntry = true
		let showHideButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: frame.height))
		showHideButton.setImage(image, for: .normal)
		showHideButton.setTitle("  ", for: .normal)
		rightViewMode = .always
		rightView = showHideButton
		showHideButton.addTarget(self, action: #selector(showHideButtonAction(_:)), for: .touchUpInside)
	}
	
	@objc func showHideButtonAction(_ sender: UIButton) {
		isSecureTextEntry = !isSecureTextEntry
//		(rightView as! UIButton).setImage(isSecureTextEntry ? KCImageConstants.eyeActive : KCImageConstants.eyeInactive, for: .normal)
	}
}
