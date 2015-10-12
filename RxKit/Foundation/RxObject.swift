//
//  RXObject.swift
//  RxKit
//
//  Created by Adam Venturella on 10/10/15.
//  Copyright © 2015 Adam Venturella. All rights reserved.
//

import Foundation
import RxSwift

public class RxObject: NSObject, RxPublisherType, RxSubscriberType{

    public lazy var publisher: PublishSubject<RxEvent<RxObject>> = {
        return self.initRxPublisher()
    }()

    public lazy var disposeBag: DisposeBag = {
        return self.initRxDisposeBag()
    }()
}
