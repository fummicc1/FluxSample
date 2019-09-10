//
//  ViewController.swift
//  FluxSample
//
//  Created by Fumiya Tanaka on 2019/09/08.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import UIKit
import RxSwift

class TimelineViewController: UIViewController {

    @IBOutlet private weak var scopeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var memoTableView: UITableView!
    @IBOutlet private weak var addMemoButton: UIButton!
    
    private var viewModel: TimelineViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configure() {
        let scopeDriver = scopeSegmentedControl.rx.value.asDriver()
        let addMemoButtonDriver = addMemoButton.rx.tap.asDriver()
        viewModel = TimelineViewModel()
    }


}

