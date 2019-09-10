//
//  Store.swift
//  FluxSample
//
//  Created by Fumiya Tanaka on 2019/09/08.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class Store {
    
    let disposeBag = DisposeBag()
    
    func bind<O, E>(_ observable: O, _ parameter: BehaviorRelay<E>) where O: ObserverType, E == O.Element {
    }
    
}
