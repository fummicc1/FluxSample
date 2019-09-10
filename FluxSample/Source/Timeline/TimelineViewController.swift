//
//  ViewController.swift
//  FluxSample
//
//  Created by Fumiya Tanaka on 2019/09/08.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TimelineViewController: UIViewController {

    @IBOutlet private weak var scopeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var memoTableView: UITableView!
    @IBOutlet private weak var addMemoButton: UIButton!
    
    private var dataSource: TimelineDataSource?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configure() {
        let scopeDriver = scopeSegmentedControl.rx.value.asDriver()
        let addMemoButtonDriver = addMemoButton.rx.tap.asDriver()
        
        dataSource = TimelineDataSource()
        
        dataSource?.store.moveToAdd.bind(to: moveToAddScene).disposed(by: disposeBag)
    }
}

extension TimelineViewController {
    var moveToAddScene: Binder<Void> {
        return Binder(self) { (viewController, value) in
            guard let addMemoViewController = UIStoryboard(name: "AddMemo", bundle: nil).instantiateInitialViewController() else {
                return
            }
            viewController.present(addMemoViewController, animated: true, completion: nil)
        }
    }
}

