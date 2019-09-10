//
//  TimelineAction.swift
//  FluxSample
//
//  Created by Fumiya Tanaka on 2019/09/10.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import Foundation
import RxSwift

enum TimelineAction: Action {
    case getMemos([Entity.Memo])
    case changeScope(DisclosureScope)
    case moveToAddScene
}
