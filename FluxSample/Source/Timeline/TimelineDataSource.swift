//
//  TimelineDataSource.swift
//  FluxSample
//
//  Created by Fumiya Tanaka on 2019/09/10.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TimelineDataSource: NSObject {
    let store: TimelineStore
    let actionCreator: TimelineActionCreator
    
    init(store: TimelineStore = TimelineStore(), actionCreator: TimelineActionCreator = TimelineActionCreator()) {
        self.store = store
        self.actionCreator = actionCreator
    }
    
    func configure(with tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension TimelineDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.memoList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = store.memoList[indexPath.row].title
        return cell ?? UITableViewCell()
    }
}
