# AutoScout Fruits.

## Requirements

Write an app to show fruits with information such as weight, photo.

## Installation

Use Xcode 12.

Install command-line tools.

Install SwiftGen (optional).

## Usage

You can use local fruits or download them from Github(a default option).

```
// ContentViewBusinessLogic.swift
private var useLocalData = false
```

## Features
Changelog v1.1:

1. Added Offline mode support. 
The UI works with a cache by default and doesn't know anything about the internet connection.

    1. FruitsProvider downloads the data and instructs FruitManager to cache it.
    2. ContentViewBusinessLogic manages contentViewData that holds fruits view models for the UI displaying.
    3. ContentViewBusinessLogic observes changes from FruitManager and loads models from it
    4. ContentView displays the data from ContentViewData
    5. FruitManager is responsible for CRUD operations on a separate queue
    6. FruitCache is responsible for CRUD operations directly to Realm DB
2. Added DependencyInjector - production tested minimalistic dependency injector written by Anton Sokolchenko (original reference: https://avdyushin.ru/posts/swift-property-wrappers/ )
3. Realm DB Objects are never used in services or UI. We never want to pass the Objects between threads.  
This behavior is **not** desired, because it leads to crashes.  
Instead, Swift Structs are passed between services, and crashes never occur.
4. QueueExecutable is a custom made synchronization toolkit.  
It uses BoltsTask to chain operations and wraps GDC queue into convenient synchronization blocks.  
Read operatinos are executed concurrently, Write operations use barrier block and are executed sequentially.

Changelog v1.0:

1. The app is written using SwiftUI  - yeah, who doesn't like new libraries and features from Apple?
2. The Network layer uses fancy CombineAPI (FruitClient.swift)
3. The localizable files are generated using SwiftGen to prevent typos
4. The logic follows SOLID principles:

* Network layer downloads data.
* ViewModels are used for SwiftUI displaying.
* Views only display data
* FruitsProvider manages the downloading of the fruits and storing them into a temporary array
5. ImageWithURL replaces Apple's Image class and supports both local and remote images. Remote images are cached using Apple's caching API.
6. Custom Settings view has been added to make the app look more polished.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.



## License
[MIT](https://choosealicense.com/licenses/mit/)

## References
https://github.com/pelumy/Fructus