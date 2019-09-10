//
//  TimelineActionCreator.swift
//  FluxSample
//
//  Created by Fumiya Tanaka on 2019/09/10.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TimelineUseCase {
    func getMemos()
    func changeScope(scope: DisclosureScope)
    func moveToAddScene()
}

class TimelineActionCreator: ActionCreator, TimelineUseCase {
    
    private let dispatcher: Dispatcher
    private let apiClient: APIRepository
    
    required init(with dispatcher: Dispatcher = .shared, api apiClient: APIRepository = APIClient()) {
        self.dispatcher = dispatcher
        self.apiClient = apiClient
    }
    
    func getMemos() {
        _ = apiClient.read(type: Entity.Memo.self, collectionName: "memos").asObservable().materialize().share().do(onNext: { [weak self] (event: Event<[Entity.Memo]>) in
            guard let self = self , let memos = event.element else {
                return
            }
            self.dispatcher.dispatch(TimelineAction.getMemos(memos))
        })
    }
    
    func moveToAddScene() {
        self.dispatcher.dispatch(TimelineAction.moveToAddScene)
    }
    
    func changeScope(scope: DisclosureScope) {
        self.dispatcher.dispatch(TimelineAction.changeScope(scope))
    }
}
