//
//  UITableView+Ext.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 30/07/22.
//

import Foundation
import UIKit

extension UITableView {
    func registerNIB(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        NSLog(className)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }

    func dequeueCell<T>(with cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: cellClass)) as? T
    }
}
