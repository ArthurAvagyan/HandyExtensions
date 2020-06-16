//
//  HEScrollView.swift
//  Handy Extensions
//
//  Created by Arthur Avagyan on 6/15/20.
//

import UIKit

extension UITableView {
	
	func scrollToFirstRow(animated: Bool) {
		scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: animated)
	}
	
	func scrollToLastRow(forRows count: Int, animated: Bool) {
		scrollToRow(at: IndexPath(row: count - 1, section: 0), at: .bottom, animated: animated)
	}
	
	func scrollTo(indexPath: IndexPath, animated: Bool) {
		let nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
		scrollToRow(at: nextIndexPath, at: .top, animated: animated)
	}
	
	func scrollToSelectedRow(animated: Bool) {
		let selectedRows = self.indexPathsForSelectedRows
		guard let selectedRow = selectedRows?[0] else {
			return
		}
		scrollToRow(at: selectedRow, at: .middle, animated: animated)
	}
}

extension UIScrollView {
	
	func scrollToHeader(animated: Bool) {
		scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: animated)
	}
	
	func scrollToTop(animated: Bool) {
		setContentOffset(CGPoint(x: 0, y: UIApplication.shared.statusBarFrame.height), animated: animated)
	}
}
