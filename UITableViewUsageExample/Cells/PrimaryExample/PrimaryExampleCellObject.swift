//
//  PrimaryExampleCellObject.swift
//  UITableViewUsageExample
//
//  Created Volodymyr Andriienko on 15.03.2021.
//
//  Template generated by VAndrJ
//

import Foundation

struct PrimaryExampleCellObject: VADiffable {
    let diffId: String = UUID().uuidString
    
    let title: String
    let description: String
}