//
//  RxPublisherType.swift
//  RxKit
//
//  Created by Adam Venturella on 10/11/15.
//  Copyright © 2015 Adam Venturella. All rights reserved.
//

import Foundation
import RxSwift

public protocol RxPublisherType{
    typealias EventType = RxEvent<Self>
    var publisher: PublishSubject<EventType> {get}
}

extension RxPublisherType{

    public func initRxPublisher() -> PublishSubject<EventType>{
        // we use EventType here as the compiler thinks it's 
        // using an operator when we initialize something like
        // PublishSubject<RxEvent<Self>>()
        // Specifically: Non-associative operator is adjacent to
        // operator of same precedence   

        let subject = PublishSubject<EventType>()
        return subject
    }

    public func trigger(type: String){
        // the compiler complains about using
        // evt: EventType = EventType(type: type, data: nil, sender: self)
        // 1) it says it has no accessible initializers
        // 2) it says it cannot convert the value of RxEvent<Self> to Self.EventType
        let evt: RxEvent<Self> = RxEvent(type: type, data: nil, sender: self)
        publisher.on(.Next(evt as! EventType))
    }

    public func trigger<T>(type: String, data: T){
        // the compiler complains about using
        // evt: EventType = EventType(type: type, data: nil, sender: self)
        // 1) it says it has no accessible initializers
        // 2) it says it cannot convert the value of RxEvent<Self> to Self.EventType
        let evt: RxEvent<Self> = RxEvent(type: type, data: data, sender: self)
        publisher.on(.Next(evt as! EventType))
    }
}