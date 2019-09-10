//
//  TimelineViewModel.swift
//  FluxSample
//
//  Created by Fumiya Tanaka on 2019/09/10.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum DisclosureScope {
    case publicScope
    case privateScope
}

class TimelineViewModel {
    
    private var scope: Driver<DisclosureScope>?
}
