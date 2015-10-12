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

    public func listenToOnce<T where T: RxPublisherType>(target: T, on type: String, invoke:() -> ()) -> Disposable {
        var disposable: Disposable?

        let handler = {
            disposable?.dispose()
            invoke()
        }

        disposable = listenTo(target, on: type, invoke: handler)
        return disposable!
    }

    public func listenToOnce<T where T: RxPublisherType>(target: T, on type: String, invoke:(T) -> ()) -> Disposable {
        var disposable: Disposable?

        let handler = {(sender: T) in
            disposable?.dispose()
            invoke(sender)
        }

        disposable = listenTo(target, on: type, invoke: handler)
        return disposable!
    }

    public func listenToOnce<T, U where T: RxPublisherType>(target: T, on type: String, invoke:(T, U) -> ()) -> Disposable {
        var disposable: Disposable?

        let handler = {(sender: T, data: U) in
            disposable?.dispose()
            invoke(sender, data)
        }

        disposable = listenTo(target, on: type, invoke: handler)
        return disposable!
    }

    public func listenTo<T, U where T: RxPublisherType>(target: T, on type: String, invoke: (T, U) -> ()) -> Disposable {
        let disposable = target
        .publisher
        .filter{
            let evt = $0 as! RxEvent<T>
            return evt.type == type
        }
        .subscribeNext{
            let evt = $0 as! RxEvent<T>
            invoke(evt.sender, evt.data as! U)
        }

        disposable.addDisposableTo(disposeBag)
        return disposable

    }

    public func listenTo<T where T: RxPublisherType>(target: T, on type: String, invoke: (T) -> ()) -> Disposable {
        let disposable = target
        .publisher
        .filter{
            let evt = $0 as! RxEvent<T>
            return evt.type == type
        }
        .subscribeNext{
            let evt = $0 as! RxEvent<T>
            invoke(evt.sender)
        }

        disposable.addDisposableTo(disposeBag)
        return disposable
    }

    public func listenTo<T where T: RxPublisherType>(target: T, on type: String, invoke: () -> ()) -> Disposable {
        let disposable = target
        .publisher
        .filter{
            let evt = $0 as! RxEvent<T>
            return evt.type == type
        }
        .subscribeNext{ _ in
            invoke()
        }

        disposable.addDisposableTo(disposeBag)
        return disposable
    }
}