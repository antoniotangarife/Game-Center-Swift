Simple Class Game Center Swift  [![](http://img.shields.io/badge/iOS-8.0%2B-lightgrey.svg)]()
=====

Simple Game Center iOS Swift Class

By Yannickstephan.com

Version : 2.0

**Begin** Begin add attribute in your class Controller:
=====
```swift
var gameCenter: GameCenter! 
```


**UIViewController** In the same class add :
=====
```swift
override func viewDidLoad() {
        super.viewDidLoad()
        self.gameCenter = GameCenter(rootViewController: self)
}
```

**Methode** for Simple Class Game Center :
=====
**Things you can do**
=====

**Add Progress To An Achievement**
```swift
gameCenter.addProgressToAnAchievement(progress:Double,achievementID:String)
```
**Reset one Achievements**
```swift
gameCenter.resetAchievements(achievementID:String)
```
**Show Game Center Player**
```swift
gameCenter.showGameCenter()
```

### Legacy support
For support of iOS 7 & 8. [Yannick Stephan](https://yannickstephan.com) works hard to have as high feature parity with **Simple Game Center** as possible.

### License
The MIT License (MIT)

Copyright (c) 2014 Tobias Due Munk

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
