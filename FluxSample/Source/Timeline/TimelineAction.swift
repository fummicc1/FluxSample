//
//  TimelineAction.swift
//  FluxSample
//
//  Created by Fumiya Tanaka on 2019/09/10.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import Foundation


enum TimelineAction: Action {
    case getMemos([Entity.Memo])
}
