//
//  MainViewController.swift
//  UITableViewUsageExample
//
//  Created by Volodymyr Andriienko on 15.03.2021.
//

import UIKit
import Differ

class MainView: UIView {
    let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
    let refreshButton = UIBarButtonItem(systemItem: .refresh)
    let shuffleButton = UIBarButtonItem(systemItem: .compose)
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        addElements()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(tableView)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

class MainViewController: UIViewController {
    private let contentView = MainView()
    // MARK: - Take it to the other layer depending on your architecture if needed.
    var tableData: [VADiffable & VACellObjectTableProtocol & VACellObjectHeightTableProtocol] = []

    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addElements()
        bind()
    }
    
    @objc private func onRefresh() {
        tableData = (0...Int.random(in: 5...10)).map({ index -> VADiffable & VACellObjectTableProtocol & VACellObjectHeightTableProtocol in
            return Bool.random() ?
                PrimaryExampleCellObject(title: "Primary \(index)", description: "Description") :
                SecondaryExampleCellObject(title: "Secondary \(index)")
        })
        contentView.tableView.reloadData()
    }
    
    @objc private func onShuffle() {
        let oldData = tableData
        tableData.shuffle()
        contentView.tableView.animateRowChanges(oldData: oldData, newData: tableData, isEqual: { $0.diffId == $1.diffId })
    }
    
    private func bind() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.refreshButton.target = self
        contentView.refreshButton.action = #selector(onRefresh)
        contentView.shuffleButton.target = self
        contentView.shuffleButton.action = #selector(onShuffle)
    }
    
    private func addElements() {
        navigationItem.rightBarButtonItem = contentView.refreshButton
        navigationItem.leftBarButtonItem = contentView.shuffleButton
    }
}

// MARK: - Take it to the other layer depending on your architecture if needed.

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableData[indexPath.row].getHeight(bounding: tableView.frame)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeue(with: tableData[indexPath.row])
    }
}
