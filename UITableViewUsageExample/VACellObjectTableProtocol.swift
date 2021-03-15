//
//  VACellObjectTableProtocol.swift
//  UITableViewUsageExample
//
//  Created by Volodymyr Andriienko on 15.03.2021.
//

import UIKit

protocol VACellObjectTableProtocol {
    var cellClass: AnyClass { get }
    var cellIdentifier: String { get }
    
    func configure(cell: UITableViewCell)
}

protocol VACellObjectHeightTableProtocol {
    
    func getHeight(bounding rect: CGRect) -> CGFloat
}

extension VACellObjectTableProtocol {
    var cellIdentifier: String {
        return String(describing: type(of: self))
    }
}
