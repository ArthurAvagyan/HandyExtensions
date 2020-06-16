//
//  HECollectionViewCell.swift
//  Handy Extensions
//
//  Created by Arthur Avagyan on 6/15/20.
//

import UIKit

class HEHoldCollectionViewCell: UICollectionViewCell {
    
	private var didFinishAnimating = false
	private var didCancelAnimating = false
	private var touchesEnded = false
	
	var onHold: (() -> Void)?
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
		didFinishAnimating = false
		didCancelAnimating = false
		touchesEnded = false
        animate(isHighlighted: true)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
		touchesEnded = true
        animate(isHighlighted: false)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
		didCancelAnimating = true
        animate(isHighlighted: false)
    }

    private func animate(isHighlighted: Bool) {
		UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
			self.transform = isHighlighted ? .init(scaleX: 0.96, y: 0.96) : .identity
		}) { (_) in
			self.didFinishAnimating = true
			if let onHold = self.onHold, !self.didCancelAnimating, self.didFinishAnimating, !self.touchesEnded {
				onHold()
			}
		}
    }
}
