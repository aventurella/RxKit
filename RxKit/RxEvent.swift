//
//  RxEvent.swift
//  RxKit
//
//  Created by Adam Venturella on 10/11/15.
//  Copyright © 2015 Adam Venturella. All rights reserved.
//

import Foundation

public struct RxEvent<T>{

    public let type: String
    public let data: Any?
    public let sender: T

    public init(type: String, data: Any?, sender: T){
        self.type = type
        self.data = data
        self.sender = sender
    }
}