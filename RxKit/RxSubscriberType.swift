//
//  RxSubscriberType.swift
//  RxKit
//
//  Created by Adam Venturella on 10/11/15.
//  Copyright © 2015 Adam Venturella. All rights reserved.
//

import Foundation
import RxSwift

public protocol RxSubscriberType{
    var disposeBag: DisposeBag {get}
}

extension RxSubscriberType{
    public func initRxDisposeBag() -> DisposeBag{
        return DisposeBag()
    }

    public func listenTo<T, U where T: RxPublisherType>(target: T, on type: String, invoke: (T, U) -> ()){
        target
        .publisher
        .filter{
            let evt = $0 as! RxEvent<T>
            return evt.type == type
        }
        .subscribeNext{
            let evt = $0 as! RxEvent<T>
            invoke(evt.sender, evt.data as! U)
        }
        .addDisposableTo(disposeBag)
    }

    public func listenTo<T where T: RxPublisherType>(target: T, on type: String, invoke: (T) -> ()){
        target
        .publisher
        .filter{
            let evt = $0 as! RxEvent<T>
            return evt.type == type
        }
        .subscribeNext{
            let evt = $0 as! RxEvent<T>
            invoke(evt.sender)
        }
        .addDisposableTo(disposeBag)
    }

    public func listenTo<T where T: RxPublisherType>(target: T, on type: String, invoke: () -> ()){
        target
        .publisher
        .filter{
            let evt = $0 as! RxEvent<T>
            return evt.type == type
        }
        .subscribeNext{ _ in
            invoke()
        }
        .addDisposableTo(disposeBag)
    }
}