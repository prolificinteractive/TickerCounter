# TickerCounter

## Description

A counter with a customizable ticker animation.

## Requirements

* iOS 10.0+
* Swift 4.2 +

## Installation

### CocoaPods
TickerCounter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod 'TickerCounter', :git => 'https://github.com/ProlificInteractive/TickerCounter.git', :tag => '1.0.0'
```

## Usage

Create a `TickerCounter` instance programmatically or in Interface Builder

Configure the `TickerCounter` instance with the desired options. To get a feel for the options, open and run the demo app where you'll be able to play with the different settings

```swift
tickerCounter.textColor = .black
tickerCounter.font = UIFont.boldSystemFont(ofSize: 50)
tickerCounter.alignment = .center
tickerCounter.duration = 0.75
tickerCounter.setPlaceholder(text: "000000")
tickerCounter.numberFormat = .currency
```
Set the value 

```
tickerCounter.value = 99999
```

Start the animation when desired

```swift
tickerCounter.startAnimation()
```

Change the va


## Contributing to TickerCounter

To report a bug or enhancement request, feel free to file an issue under the respective heading.

If you wish to contribute to the project, fork this repo and submit a pull request. Code contributions should follow the standards specified in the [Prolific Swift Style Guide](https://github.com/prolificinteractive/swift-style-guide).

## License

![prolific](https://s3.amazonaws.com/prolificsitestaging/logos/Prolific_Logo_Full_Color.png)

Copyright (c) 2018 Prolific Interactive

TickerCounter is maintained and sponsored by Prolific Interactive. It may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: ./LICENSE
