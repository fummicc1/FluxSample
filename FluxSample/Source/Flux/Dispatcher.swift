//
//  Dispatcher.swift
//  Darumasan
//
//  Created by Fumiya Tanaka on 2019/09/10.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import Foundation
import RxSwift

/// アプリケーションから使用する場合はシングルトン
/// テストで使用する場合は新しくインスタンスを作成する
final class Dispatcher {
    static let shared = Dispatcher()
    
    private let dispatcher = PublishSubject<Action>()
    
    func register<A: Action>(handler: @escaping (_ action: A) -> ()) -> Disposable {
        return dispatcher.subscribe(onNext: { (action) in
            guard let action = action as? A else { return }
            handler(action)
        })
    }
    
    func dispatch(_ action: Action) {
        dispatcher.onNext(action)
    }
    
    func unregister(_ disposable: Disposable) {
        disposable.dispose()
    }
}
