![Bulldog: Json Parser](https://raw.githubusercontent.com/freesuraj/Bulldog/master/Assets/logo.png)

[![Build Status](https://travis-ci.org/freesuraj/Bulldog.svg?branch=master)](https://travis-ci.org/freesuraj/Bulldog)
[![Coverage Status](https://coveralls.io/repos/github/freesuraj/Bulldog/badge.svg?branch=master)](https://coveralls.io/github/freesuraj/Bulldog?branch=master)
[![Code Climate](https://codeclimate.com/github/freesuraj/Bulldog/badges/gpa.svg)](https://codeclimate.com/github/freesuraj/Bulldog)
[![Issue Count](https://codeclimate.com/github/freesuraj/Bulldog/badges/issue_count.svg)](https://codeclimate.com/github/freesuraj/Bulldog)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Bulldog.svg)](http://cocoadocs.org/docsets/Bulldog/)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/Bulldog.svg?style=flat)](http://cocoadocs.org/docsets/Bulldog)
[![Twitter](https://img.shields.io/badge/twitter-@iosCook-blue.svg?style=flat)](http://twitter.com/iosCook)

# Bulldog
Bulldog is a super-fast json parser that will keep attacking until it gets the value you desire, or you give up. Just like a bulldog.

## Why Bulldog?

- ✅ Super-light
- ✅ Easily extendible
- ✅ Can easily traverse through path of a json object to get the final value while ignoring the type of intermediate objects
- ✅ Utilises the apple's JSONSerialization underneath
- ✅ Well tested with 100% test coverage

## Example Usage

Let's suppose we want to parse the following JSON object

### response.json

```
{
   "id":123,
   "first_name":"Conor",
   "last_name":"McGregor",
   "age":28,
   "height": 171,
   "weight":70.5,
   "fights":[
      {
         "id":"UFC 205",
         "opponent":"Eddie Alvarez",
         "venue":"New York",
         "win":true
      },
      {
         "id":"UFC 202",
         "opponent":"Nate Diaz",
         "venue":"Las Vegas",
         "win":true
      },
      {
         "id":"UFC 196",
         "opponent":"Nate Diaz",
         "venue":"Las Vegas",
         "win":false
      }
   ]
}
```

### parser.swift

Now to parse the above json file,

```swift
let json: Any = ... // Json from network
let bulldog = Bulldog(json: json)
let name = bulldog.string("first_name") + " " + bulldog.string("last_name") // Conor McGregor

let height = bulldog.int("height") // 171
let weight = bulldog.double("weight") // 70.5

// Get first opponent of his fights
let firstOpponent = bulldog.string("fights", 0, "opponent") // Eddie Alvarez
// Get fights array
let fights = bulldog.array("fights") // Returns array of fights

// Return the first fight dictionary
let firstFight = bulldog.dictionary("fights", 0) // Returns first fight dictionary

// Check if first fight was a win
let isWin = Bulldog(json: fights[0]).boolean("win") // Returns true

```

## Installation

### Carthage
Bulldog is available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Cartfile:

```ruby
git "freesuraj/Bulldog"
```

### Cocoapods
Add the following line to your Podfile:
```ruby
pod 'Bulldog'
```
### Manual
Perhaps the easiest way to use is to just copy the file [Bulldog.swift](https://github.com/freesuraj/Bulldog/blob/master/Source/Bulldog.swift) and put it in your project. That's it !!

## Example

Please check the [BulldogTests.swift](https://github.com/freesuraj/Bulldog/blob/master/Tests/BulldogTests.swift) file for all possilbe use cases

## About

If you found this little tool useful, I'd love to hear about it. You can also follow me on Twitter at [@iosCook](https://twitter.com/ioscook)


## License

Bulldog is available under the MIT license. See the LICENSE file for more info.


