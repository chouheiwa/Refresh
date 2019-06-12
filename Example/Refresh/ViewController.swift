//
//  ViewController.swift
//  Refresh
//
//  Created by chouheiwa on 06/11/2019.
//  Copyright (c) 2019 chouheiwa. All rights reserved.
//

import UIKit
import Refresh

import RxCocoa
import RxSwift

class ViewController: UIViewController, Refresher {
    let haveMoreData: BehaviorRelay<Bool> = BehaviorRelay(value: false)

    let endHeaderRefresh: BehaviorRelay<Void> = BehaviorRelay(value: ())

    let disposeBag: DisposeBag = DisposeBag()

    func loadLatestData() {
        haveMoreData.accept(true)
        endHeaderRefresh.accept(())
    }

    func loadMoreData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.haveMoreData.accept(false)
        }
    }

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.noMoreDataShowFooter = false

        tableView.registerRefresher(self)

        loadLatestData()

        tableView.tableFooterView = UIView(frame: CGRect.zero)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

