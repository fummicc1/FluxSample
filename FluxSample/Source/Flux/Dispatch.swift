//
//  DIspatcher.swift
//  FluxSample
//
//  Created by Fumiya Tanaka on 2019/09/08.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import Foundation
import RxSwift

class DispatchSubject<Element>: ObservableType, ObserverType {
    
    fileprivate let subject = PublishSubject<Element>()
    
    func dispatch(_ value: Element) {
    }
    
    func on(_ event: Event<Element>) {
        subject.on(event)
    }
    
    func subscribe<Observer>(_ observer: Observer) -> Disposable where Observer : ObserverType, Element == Observer.Element {
        return subject.subscribe(observer)
    }
}
