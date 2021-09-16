# AutoScout Fruits.

## Requirements

Write an app to show fruits with the information such as weight, photo.

## Installation

Use Xcode 12.

Install command-line tools.

Install SwiftGen (optional).

## Usage

You can use local fruits or download them from Github(a default option).

```
// ContentView.swift
@State var useLocalData: Bool = false
```

## Features
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