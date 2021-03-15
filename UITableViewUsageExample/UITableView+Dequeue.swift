//
//  UITableView+Dequeue.swift
//  UITableViewUsageExample
//
//  Created by Volodymyr Andriienko on 15.03.2021.
//

import UIKit

extension UITableView {
    
    func dequeue(with object: VACellObjectTableProtocol) -> UITableViewCell {
        if let cell = dequeueReusableCell(withIdentifier: object.cellIdentifier) {
            object.configure(cell: cell)
            return cell
        } else {
            register(object.cellClass, forCellReuseIdentifier: object.cellIdentifier)
            return dequeue(with: object)
        }
    }
}
