//
//  APIClient.swift
//  FluxSample
//
//  Created by Fumiya Tanaka on 2019/09/09.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import Foundation
import Firebase
import RxSwift
import RxCocoa
import FirebaseFirestoreSwift

protocol APIRepository {
    func create<V: EntityModel>(value: V, collectionName: String) -> Single<Void>
    func update<V: EntityModel>(value: V, collectionName: String) -> Single<Void>
    func read<V: EntityModel>(collectionName: String) -> Single<[V]>
    func delete<V: EntityModel>(value: V, collectionName: String) -> Single<Void>
}

enum APIError: Error {
    case failedToEncode
    case noUpdateID
    case serverError(Error)
    case failedToDecode
    case noSnapshots
}

class APIClient: APIRepository {
    func create<V>(value: V, collectionName: String) -> Single<Void> where V : EntityModel {
        return Single.create(subscribe: { (singleEvent) -> Disposable in
            let document = value.id == nil ? Firestore.firestore().collection(collectionName).document() : Firestore.firestore().collection(collectionName).document(value.id!)
            guard var data = try? Firestore.Encoder().encode(value) else {
                singleEvent(.error(APIError.failedToEncode))
                return Disposables.create()
            }
            data["id"] = document.documentID
            data["createdAt"] = FieldValue.serverTimestamp()
            data["updatedAt"] = FieldValue.serverTimestamp()
            document.setData(data, merge: true) { error in
                if let error = error {
                    singleEvent(.error(APIError.serverError(error)))
                    return
                }
                singleEvent(.success(()))
            }
            return Disposables.create()
        })
    }
    
    func update<V>(value: V, collectionName: String) -> Single<Void> where V : EntityModel {
        return Single.create(subscribe: { (singleEvent) -> Disposable in
            guard let id = value.id else {
                singleEvent(.error(APIError.noUpdateID))
                return Disposables.create()
            }
            guard var data = try? Firestore.Encoder().encode(value) else {
                singleEvent(.error(APIError.failedToEncode))
                return Disposables.create()
            }
            data["updatedAt"] = FieldValue.serverTimestamp()
            Firestore.firestore().collection(collectionName).document(id).setData(data, merge: true) { error in
                if let error = error {
                    singleEvent(.error(APIError.serverError(error)))
                    return
                }
                singleEvent(.success(()))
            }
            return Disposables.create()
        })
    }
    
    func read<V>(collectionName: String) -> PrimitiveSequence<SingleTrait, [V]> where V : EntityModel {
        return Single.create(subscribe: { (singleEvent) -> Disposable in
            Firestore.firestore().collection(collectionName).getDocuments(completion: { (snapshots, error) in
                if let error = error {
                    singleEvent(.error(APIError.serverError(error)))
                    return
                }
                guard let snapshots = snapshots else {
                    singleEvent(.error(APIError.noSnapshots))
                    return
                }
                var valueList: [V] = []
                for document in snapshots.documents {
                    guard let value = try? Firestore.Decoder().decode(V.self, from: document.data()) else {
                        singleEvent(.error(APIError.failedToDecode))
                        return
                    }
                    valueList.append(value)
                }
                singleEvent(.success(valueList))
            })
            return Disposables.create()
        })
    }
    
    func delete<V>(value: V, collectionName: String) -> Single<Void> where V : EntityModel {
        return Single.create(subscribe: { (singleEvent) -> Disposable in
            return Disposables.create()
        })
    }
    
}
