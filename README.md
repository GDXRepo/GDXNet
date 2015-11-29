# GDXNet

Well-organized Objective-C network interaction library.

## Adding GDXNet to your project

### CocoaPods

[CocoaPods](http://cocoapods.org) is the recommended way to add GDXNet to your project.

1. Add a pod entry for GDXNet to your Podfile `pod 'GDXNet'`
2. Update the pod(s) by running `pod update`.
3. Include library files wherever you need it with `#import "GDXNet.h"`.

## Supported Interactions
At now `GDXNet` supports only RESTful protocol. Sockets support is in progress, I'm working on it.


## Quick Guide

Let's imagine that you want to interact with a RESTful back-end server with API entry point URL `http://myserver.com/api/`. Also this server takes us only one POST-method with this specification:

```
Name: getHistory
HTTP Method: POST
Response Type: JSON
```
Create a subclass from `GDXNetPacket` class named `MyServerPacket` from and implement `GDXRESTPacket` protocol. This is our API entry point class. Next, setup your class with the following properties:

```objective-c
@implementation MyServerPacket

- (instancetype)initWithJSON:(id)json {
    return [super init]; // our root packet will not parse any input JSON
}

- (void)parseResponse:(id)response error:(NSError *)error {
    // empty
}

- (NSString *)urlBase {
    return @"http://myserver.com/api/";
}

- (NSString *)urlRelative {
    NSAssert(0, nil); // root packet has no relative URL
    return nil;
}

- (NSArray *)headers {
    return @[]; // no headers by default
}

- (NSDictionary *)params {
    return @{}; // no API method's input parameters by default
}

- (GDXRESTPacketType)type {
    return GDXRESTPacketTypePOST; // for our server default HTTP method is POST
}

- (GDXRESTPacketOptions *)options {
    GDXRESTPacketOptions *options = [GDXRESTPacketOptions new];
    options.cacheAllowed = NO; // forbid cache
    options.silent = NO; // silent requests, see 'GDXRESTPacketOptions' explanation below
    options.repeatOnSuccess = NO; // should be auto-repeated on success
    options.repeatOnFailure = NO; // should be auto-repeated on failure
    options.timeout = 30; // request timeout
    
    return options;
}

- (GDXRESTOperationType)requestType {
    return GDXRESTOperationTypeHTTP; // default request type is HTTP
}

- (GDXRESTOperationType)responseType {
    return GDXRESTOperationTypeHTTP; // default response type is HTTP
}

@end
```

Now we should handle our single API's method. Create subclass from your `MyServerPacket` class named `GetHistoryPacket` and specify its properties like this:

```objective-c
@implementation GetHistoryPacket

- (void)parseResponse:(id)response error:(NSError *)error {
    NSLog(@"Data received: %@", response);
}

- (NSString *)urlRelative {
    return @"getHistory";
}

@end
```

And now, of course, we need a model class which will manage our requests. Create a class named `MyServerEntry` from `NSObject` and describe it like this:

```objective-c
@implementation MyServerEntry

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(processContext:)
         name:kGDXNetAdapterDidReceiveResponseNotification
         object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)requestGetHistory {
    [[GDXNet instance] send:[GetHistoryPacket new] userInfo:nil method:GDXNetSendMethodREST];
}

- (void)processContext:(NSNotification *)notification {
    NSLog(@"Parsed context with packet inside: %@", (GDXNetContext *)notification.object);
}
```

That's it. Now you can use your entry point like this:

```objective-c
self.entry = [MyServerEntry new]; // strong property, for example
[entry requestGetHistory]; // you will see results in Xcode console output
```

Inside `processContext:` method you will receive an instance of the `GDXNetContext` class with your parsed packet inside and some set of useful supporting properties.

## Classes Hierarchy
If you want to deep understand the library's structure, please read the following article. It describes all classes in the library.

### GDXNetPacket class + GDXRESTPacket protocol
Subclassing `GDXNetPacket` gives you a unique identifier of your packet. Implementing `GDXRESTPacket` protocol gives you an opportunity to describe your packet according to REST interaction protocol. After this you will be able to send your packet with `GDXNetMethodREST` method via `GDXNet` facade class instance (see its description below).

### GDXNetContext class
All packets sending via `GDXNet` have their own context, which contains unique context ID (it does not relate to packet's ID), allowed packets protocols which can be wrapped with this context subclass, `isCancelled` property, which allows you to manage cancelled requests, some `userInfo` dictionary for your own purposes and, of course, your `GDXNetPacket` subclass instance. All this data placed in the `GDXNetContext` abstract wrapping class.

You will have a deal with some concrete subclass of the `GDXNetContext` which provides you additional specific information. For now there is only one concrete subclass named `GDXRESTContext` for REST protocol.

### GDXNetAdapter class
Abstract adapter which contains methods for sending and cancelling your packets. Also manages asynchronous parsing responses inside your packets (response will not be parsed if you've cancelled your request manually). After successful or failed requests `GDXNetAdapter` posts a notification which informs you about finishing your request. Please note that cancelled requests will be passed as **failed** requests.

You will use the `GDXRESTAdapter` subclass to interact with REST contexts.

### GDXNet class
Facade singleton class with two methods described below:

```objective-c
- (NSDictionary<NSNumber *, NSString *> *)send:(GDXNetPacket *)packet userInfo:(NSDictionary *)userInfo method:(GDXNetSendMethod)method;
- (void)cancelRequestByContextId:(NSString *)contextId;
```
You can send your packet (a subclass of your custom class, which, in turn, is subclassed from `GDXNetPacket` **concrete** subclass) with specified set of sending methods (`GDXNetSendMethod` is just a bitmask enumeration). `GDXNet` will choose valid adapters for your packet according to specified sending methods, after that your packet will be sent via all these adapters. That's it.

This method returns you a dictionary with set of pairs: `sending method` (as a key) => `context ID` (as a value). After this you can cancel your request using received context ID.

### Conclusion

As you can see, if your packet implements `GDXRESTPacket` protocol, it can be sent with `GDXNetSendMethodREST` method. When I add sockets support, your packets will be able to implement sockets packet protocol and be sent with sockets sending method. All of your network interaction is separated into layers, all your packets are clean and standalone, all your requests have their central entry point. Clear and simple.

## Samples

You can find sample project inside the `Samples` folder.

## License

Apache. See `LICENSE` for details.
