# RxKit
Utilities for RxSwift

## Installing
Add the following to tour Cartfile:

```
github "aventurella/RxKit"
```

## Events

RxKit contains a simple event system conceptually similar to the one found
in `[Backbone][backbone]/[Marionette][marionette]` in the JavaScript world.
Delegates! I hear you roar. Yes, delegates. I have tried both ways, delegates and events and
I like events better for simple contrtoller -> controller communication.
I used to be firmly on the delegate camp however if that syas anything.

There are 2 protocols you can implement:
- `RxPublisherType`
- `RxSubscriberType`

`RxPublisherType` gives you the ability to `trigger` events and
`RxSubscriberType` gives you the ability to `listenTo` events. In most
cases if you implement these protocols you will be implementing both
on your object. Take a look at Foundation/RxObject for example. It is
both a subscriber and a publisher.

There are 2 provided implementations at the moment for
`RxPublisherType` + `RxSubscriberType`

1) Foundation/RxObject - NSObject Subsclass
2) UIKit/RxViewController - UIViewController Subsclass

## Events Example

You can find additional samples in the unit tests as well.

```swift
let obj1 = RxObject()
let obj2 = RxObject()

obj2.listenTo(obj1, on: "foo"){
    print("GOT HERE!")
}

obj1.trigger("foo")
```

You can also get more information from you event handler, and you can
send along data as well.


```swift
// Who sent the message?

let obj1 = RxObject()
let obj2 = RxObject()

obj2.listenTo(obj1, on: "foo"){ (sender: RxObject) in
    print("\(sender) GOT HERE!")
}

obj1.trigger("foo")
```

```swift
// Lets get some more data!

let obj1 = RxObject()
let obj2 = RxObject()

obj2.listenTo(obj1, on: "foo"){ (_, data: String) in
    print("\(data) GOT HERE!")
}

obj1.trigger("foo", data: "Lucy")
```

```swift
// even complex data!

struct Message{
    let name: String
}

let obj1 = RxObject()
let obj2 = RxObject()
let message = Message(name: "Lucy")

obj2.listenTo(obj1, on: "foo"){ (_, data: Message) in
    print("\(message.name) GOT HERE!")
}

obj1.trigger("foo", data: message)
```

[backbone]: http://backbonejs.org/  "Backbone"
[marionette]: http://marionettejs.com/  "Marionette"
