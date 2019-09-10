//
//  ActionCreator.swift
//  Darumasan
//
//  Created by Fumiya Tanaka on 2019/09/10.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ActionCreator {
    init(with dispatcher: Dispatcher, api apiClient: APIRepository)
}

//class ActionCreator: ActionCreatorProtocol {
////    func loadMemoList() -> Observable<[Entity.Memo]> {
////        let memoListObservable = apiClient.read(type: Entity.Memo.self, collectionName: "memos").asObservable().share()
////        return memoListObservable.catchError({ (error) -> Observable<[Entity.Memo]> in
////            // TODO: エラーメッセージの表示
////            return .just([])
////        })
////    }
////
////    func addMemo(memo: Entity.Memo) -> Observable<Void> {
////        //TODO: エラー処理を後で書く。
////        return apiClient.create(value: memo, collectionName: "memos").asObservable().share()
////    }
//}
