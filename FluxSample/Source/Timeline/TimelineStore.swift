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

enum DisclosureScope {
    case publicScope
    case privateScope
}

class TimelineStore: Store {
    
    private let dispatcher: Dispatcher
    private var memoListRelay: BehaviorRelay<[Entity.Memo]> = .init(value: [])
    private var disClosureScopeRelay: BehaviorRelay<DisclosureScope> = .init(value: .publicScope)
    private var moveToAddRelay: PublishRelay<Void> = .init()
    
    var memoList: [Entity.Memo] {
        return memoListRelay.value
    }
    var disClosureScope: DisclosureScope {
        return disClosureScopeRelay.value
    }
    var moveToAdd: Observable<Void> {
        return moveToAddRelay.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    required init(with dispatcher: Dispatcher = .shared) {
        self.dispatcher = dispatcher
        dispatcher.register { [weak self] (action: TimelineAction) in
            guard let self = self else { return }
            switch action {
            case .getMemos(let memos):
                self.memoListRelay.accept(memos)
            case .changeScope(let scope):
                self.disClosureScopeRelay.accept(scope)
            case .moveToAddScene:
                self.moveToAddRelay.accept(())
            }
        }.disposed(by: disposeBag)
    }
}
