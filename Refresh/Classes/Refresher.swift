//
//  Refresher.swift
//  Refresh
//
//  Created by Di on 2019/6/11.
//

import RxCocoa
import RxSwift

public protocol Refresher: class {
    var haveMoreData: BehaviorRelay<Bool> { get }

    var endHeaderRefresh: BehaviorRelay<Void> { get }

    var disposeBag: DisposeBag { get }

    func loadLatestData()

    func loadMoreData()
}
