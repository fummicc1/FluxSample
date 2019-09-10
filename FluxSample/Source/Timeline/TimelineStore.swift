//
//  TimelineStore.swift
//  FluxSample
//
//  Created by Fumiya Tanaka on 2019/09/10.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TimelineStore: Store {
    
    private let dispatcher: Dispatcher
    
    private var memoListRelay: BehaviorRelay<[Entity.Memo]> = .init(value: [])
    private let disposeBag = DisposeBag()
    
    required init(with dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
        dispatcher.register { [weak self] (action: TimelineAction) in
            guard let self = self else { return }
            switch action {
            case .getMemos(let memos):
                self.memoListRelay.accept(memos)
            }
        }.disposed(by: disposeBag)
    }
}
