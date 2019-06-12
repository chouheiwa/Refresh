//
//  UITableView+Refresh.swift
//  Refresh
//
//  Created by Di on 2019/6/11.
//

import UIKit
import MJRefresh

import RxCocoa
import RxSwift

extension UIScrollView {
    private struct AssociatedKeys {
        static var noMoreDataShowFooterKey = "noMoreDataShowFooter"
        private init() {}
    }

    public var noMoreDataShowFooter: Bool {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.noMoreDataShowFooterKey) as? NSNumber else {
                return true
            }

            return value.boolValue
        }

        set {
            return objc_setAssociatedObject(self, &AssociatedKeys.noMoreDataShowFooterKey, NSNumber(booleanLiteral: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public func registerRefresher(_ refresher: Refresher)  {
        let header = MJRefreshNormalHeader(refreshingBlock: { [weak refresher] in
            refresher?.loadLatestData()
        })!

        setupRefreshHeader(header)

        self.mj_header = header

        let footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak refresher] in
            refresher?.loadMoreData()
        })

        setupRefreshFooter(footer!)

        refresher.endHeaderRefresh.subscribe(onNext: {
            header.endRefreshing()
        }).disposed(by: refresher.disposeBag)

        refresher.haveMoreData.subscribe(onNext: { [weak self] (haveMoreData) in
            guard let self = self else {return}

            let function = haveMoreData ? footer?.endRefreshing : footer?.endRefreshingWithNoMoreData

            function?()

            guard !haveMoreData else {
                self.mj_footer = footer
                return
            }

            self.mj_footer = self.noMoreDataShowFooter ? footer : nil
        }).disposed(by: refresher.disposeBag)
    }

    private func setupRefreshHeader(_ header: MJRefreshNormalHeader) {
        header.lastUpdatedTimeLabel.isHidden = true

        header.setTitle("请下拉刷新数据", for: .idle)
        header.setTitle("请松开以刷新数据", for: .pulling)
        header.setTitle("正在更新数据...", for: .refreshing)
    }

    private func setupRefreshFooter(_ footer: MJRefreshAutoNormalFooter) {
        footer.setTitle("请点击或上拉刷新数据", for: .idle)
        footer.setTitle("请松开以刷新数据", for: .pulling)
        footer.setTitle("正在更新数据...", for: .refreshing)
        footer.setTitle("没有更多数据了", for: .noMoreData)
    }
}
