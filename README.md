# TickerCounter

## Description

A counter with a ticker animation.

## Requirements

* iOS 10.0+

## Installation

### CocoaPods
TickerCounter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:


```ruby
pod 'Ticker', :git => 'https://github.com/ProlificInteractive/TickerCounter.git', :tag => '0.1.0'
```

## Usage

Create a `TickerCounter` instance and tell it to animate:

```swift
let tickerCounter = TickerCounter(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 65))
tickerCounter.value = 12345
view.addSubview(tickerCounter)

tickerCounter.startAnimation()
```

## Contributing to TickerCounter

To report a bug or enhancement request, feel free to file an issue under the respective heading.

If you wish to contribute to the project, fork this repo and submit a pull request. Code contributions should follow the standards specified in the [Prolific Swift Style Guide](https://github.com/prolificinteractive/swift-style-guide).

## License

![prolific](https://s3.amazonaws.com/prolificsitestaging/logos/Prolific_Logo_Full_Color.png)

Copyright (c) 2018 Prolific Interactive

TickerCounter is maintained and sponsored by Prolific Interactive. It may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: ./LICENSE