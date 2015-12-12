#Change Log
All notable changes to this project will be documented in this file.
`GDXNet` adheres to [Semantic Versioning](http://semver.org/).

--- 

##[1.1.2](https://github.com/GDXRepo/GDXNet/releases/tag/1.1.2) (12/12/2015)
Released on Saturday, December 12, 2015.

### Added
* `GDXRESTContext` class now contains `responseHeaders` property with all HTTP headers fields from a response.

### Fixed
* Added headers support for REST packets. The `headers` property's type from the `GDXRESTPacket` protocol changed from `NSArray *` to `NSDictionary *`.
* `GDXRESTAdapter` converted for using `AFNetworking` 3.0 library version.
* Removed unused `ViewController` class from a storyboard.


##[1.0.0](https://github.com/GDXRepo/GDXNet/releases/tag/1.0.0) (29/11/2015)
Released on Sunday, November 29, 2015. 

### Summary
* Initial commit with supporting REST based on [AFNetworking](http://github.com/AFNetworking/AFNetworking) library.
