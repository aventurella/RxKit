//
//  RxViewController.swift
//  RxKit
//
//  Created by Adam Venturella on 10/11/15.
//  Copyright © 2015 Adam Venturella. All rights reserved.
//

import UIKit
import RxSwift

public class RxViewController: UIViewController, RxPublisherType, RxSubscriberType{

    public lazy var publisher: PublishSubject<RxEvent<RxObject>> = {
        return self.initRxPublisher()
    }()

    public lazy var disposeBag: DisposeBag = {
        return self.initRxDisposeBag()
    }()

    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        trigger("view:before:appear")
    }

    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        trigger("view:appear")
    }

    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        trigger("view:before:disappear")
    }

    public override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        trigger("view:disappear")
    }
}