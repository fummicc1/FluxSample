//
//  Memo.swift
//  FluxSample
//
//  Created by Fumiya Tanaka on 2019/09/09.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import Foundation
import FirebaseFirestore.FIRTimestamp
import FirebaseFirestoreSwift

protocol EntityModel: Codable {
    var id: String? { get }
    var createdAt: Timestamp? { get }
    var updatedAt: Timestamp? { get }
}

enum Entity {
    struct Memo: EntityModel {
        var id: String?
        var title: String?
        var content: String?
        var senderID: String?
        var createdAt: Timestamp?
        var updatedAt: Timestamp?
    }
}

