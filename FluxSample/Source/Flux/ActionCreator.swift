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
