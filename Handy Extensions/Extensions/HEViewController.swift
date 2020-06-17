//
//  HEViewController.swift
//  Handy Extensions
//
//  Created by Arthur Avagyan on 6/15/20.
//

import UIKit
import AVFoundation

extension UIViewController {
	
	func askForPermission(_ type: AVMediaType, _ completion: @escaping (_ granted: Bool) -> Void) {
		switch AVCaptureDevice.authorizationStatus(for: type) {
		case .authorized:
			completion(true)
		case .notDetermined:
			AVCaptureDevice.requestAccess(for: type) { (granted) in
				completion(granted)
			}
		default:
			var permission: HEPermission!
			switch type {
			case .video:
				permission = .camera
			case .audio:
				permission = .microphone
			default:
				completion(false)
			}
			askToOpenSettingsFor(permission)
		}
		completion(false)
	}
	
	func askToOpenSettingsFor(_ permission: HEPermission, appName: String = "") {
		let message = "\(appName) doesn't have permission to use the \(permission.rawValue), please change privacy settings"
		var actions: [UIAlertAction] = []
		actions.append(UIAlertAction(title: HEAlertConstants.cancel, style: .cancel))
		actions.append(UIAlertAction(title: HEAlertConstants.settings, style: .default, handler: { _ in
			UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
		}))
		
		showAlert(title: "Allow access to \(permission.rawValue)", message: message, actions: actions)
	}
	
	func showAlert(title: String, message: String, actions: [UIAlertAction] = [], completion: (() -> Void)? = nil) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		if actions.isEmpty {
			alertController.addAction(UIAlertAction(title: "Okay", style: .cancel))
		} else {
			for action in actions {
				alertController.addAction(action)
			}
		}
		
		present(alertController, animated: true, completion: completion)
	}
    
	func popTo<T: UIViewController>(_ type: T.Type) {
		for controller in self.navigationController?.viewControllers ?? [] {
			if controller.isKind(of: type) {
				self.navigationController?.popToViewController(controller, animated: true)
				break
			}
		}
	}
}


// MARK: - TabBar

extension UIViewController {
	
	func setTabBarVisible(visible: Bool, animated: Bool) {
        guard let tabBarController = self.tabBarController else { return}
        if let frame = self.tabBarController?.tabBar.frame {
            let factor: CGFloat = visible ? -1 : 1
            var y = frame.origin.y + (frame.size.height * factor)
			
            if y < UIScreen.main.bounds.height - frame.size.height {
                y = UIScreen.main.bounds.height - frame.size.height
            } else if y > UIScreen.main.bounds.height {
                y = UIScreen.main.bounds.height
            }

			UIView.animate(withDuration: animated ? 0.6 : 0, animations: {
                tabBarController.tabBar.frame = CGRect(x: frame.origin.x, y: y, width: frame.width, height: frame.height)
				self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: y)
            })
        }
    }

//    var isTabBarVisible: Bool {
//		guard let tabBar = (UIApplication.shared.keyWindow?.rootViewController as? ASMainTabBarController)?.tabBar else { return false }
//		return tabBar.frame.origin.y < UIScreen.main.bounds.height
//    }
}
