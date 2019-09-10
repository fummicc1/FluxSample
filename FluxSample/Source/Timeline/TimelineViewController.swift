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
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        addMemoButton.layer.cornerRadius = addMemoButton.frame.height / 2
        addMemoButton.layer.masksToBounds = true
    }
    
    private func configure() {
        let scopeObservable = scopeSegmentedControl.rx.value.asObservable()
        let addMemoButtonObservable = addMemoButton.rx.tap.asObservable()
        
        dataSource = TimelineDataSource()
        
        dataSource?.store
            .moveToAdd
            .bind(to: moveToAddScene)
            .disposed(by: disposeBag)
        
        scopeObservable.subscribe { [weak self] (event) in
            guard let self = self, let value = event.element else { return }
            let scope: DisclosureScope = value == 0 ? .publicScope : .privateScope
            self.dataSource?.actionCreator.changeScope(scope: scope)
        }.disposed(by: disposeBag)
        
        addMemoButtonObservable.subscribe { [weak self] (event) in
            guard let self = self else { return }
            self.dataSource?.actionCreator.moveToAddScene()
        }.disposed(by: disposeBag)
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

