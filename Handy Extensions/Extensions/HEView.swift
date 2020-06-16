//
//  HEView.swift
//  Handy Extensions
//
//  Created by Arthur Avagyan on 6/15/20.
//

import UIKit
import PureLayout

extension UIView {
	
	func loadViewFromNib<T : UIView>(owner: T) -> UIView {
        let bundle = Bundle(for: type(of: owner))
        let nib = UINib(nibName: String(describing: type(of: owner)), bundle: bundle)
		let view = nib.instantiate(withOwner: owner, options: nil).first as! UIView
        return view
    }
	
	func dropMatchingShapeShadow(_ color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 2) {
		layer.shadowColor = color.cgColor
		layer.shadowOffset = .zero
		layer.shadowOpacity = opacity
		layer.shadowRadius = radius
	}
	
	var firstResponder: UIView? {
		guard !isFirstResponder else { return self }
		
		for subview in subviews {
			if let firstResponder = subview.firstResponder {
				return firstResponder
			}
		}
		
		return nil
	}

	func removeAllConstraints() {
		if let superview = self.superview {
            for constraint in superview.constraints {
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                } else if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
        }
        removeConstraints(constraints)
    }
	
	func autoPinEdgesTo(_ view: UIView) {
		autoPinEdge(.top, to: .top, of: view, withOffset: 0, relation: .equal)
		autoPinEdge(.bottom, to: .bottom, of: view, withOffset: 0, relation: .equal)
		autoPinEdge(.leading, to: .leading, of: view, withOffset: 0, relation: .equal)
		autoPinEdge(.trailing, to: .trailing, of: view, withOffset: 0, relation: .equal)
	}

	func autoRemoveDimention(_ dimention: ALDimension) {
		for constraint in constraints {
			if let first = constraint.firstItem as? UIView, first == self, constraint.secondItem == nil {
				removeConstraint(constraint)
			}
		}
	}
    
    func setAlphaWithAnimation(isHidden: Bool) {
        let newAlpha: CGFloat = isHidden ? 0 : 1
        guard newAlpha != alpha else {return}
        alpha = isHidden ? 1 : 0
        UIView.animate(withDuration: 0.3) {
            self.alpha = newAlpha
        }
    }
}

extension NSLayoutConstraint {
	
	func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
		return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
	}
}
