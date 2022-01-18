//
//  Extensions-UITableView.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 16.01.22.
//

import UIKit

extension UITableView {

    func scrollToTheTop() {
        guard !self.visibleCells.isEmpty else { return }
        self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}
