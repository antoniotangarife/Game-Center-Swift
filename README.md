Simple Class Game Center Swift  [![](http://img.shields.io/badge/iOS-8.0%2B-lightgrey.svg)]()
=====

Simple Game Center iOS Swift Class

By Yannickstephan.com

Version : 3.0

**Begin** Add GameKit FrameWork > General > Linked Frameworks and Libraries:
[![](http://imagizer.imageshack.us/v2/640x480q90/540/cLGFV6.png)]()

**UIViewController** In your main class add :
=====
```swift
/******* ADD Protocol GADInterstitialDelegate *******/
class MyClassViewController: UIViewController, GADInterstitialDelegate {
        
        /******* ADD GameCenter Swift *******/
        var gameCenter: GameCenter! 
        
        override func viewDidLoad() {
                super.viewDidLoad()
                
                /******* ADD delegate root view controller GameCenter Swift *******/
                self.gameCenter = GameCenter(rootViewController: self)
        }
}

```

**Methode** for Simple Class Game Center :
=====
**Things you can do**
=====
**Reports a given score to Game Center**
```swift
gameCenter.reportScore(score: Int, leaderboardIdentifier: String)
```
**Add Progress To An Achievement**
```swift
gameCenter.addProgressToAnAchievement(progress:Double,achievementIdentifier:String)
```
**Reset one Achievement**
```swift
gameCenter.resetAchievements(achievementIdentifier:String)
```
**Reset All Achievements**
```swift
gameCenter.resetAllAchievements(achievementIdentifier:String)
```
**If achievement is finished**
```swift
gameCenter.isAchievementFinished(achievementIdentifier:String)
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
