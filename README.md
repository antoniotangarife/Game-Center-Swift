###Simple Class Game Center Swift  [![](http://img.shields.io/badge/iOS-8.0%2B-lightgrey.svg)]()###
[![](http://imagizer.imageshack.us/v2/320x240q90/538/RMNfHp.png)]()

Simple Game Center iOS Swift Class

By Yannickstephan.com

Version : 2.0

**Example** 
here : https://github.com/DaRkD0G/Example-GameCenter

**Begin** 
Add GameKit FrameWork > General > Linked Frameworks and Libraries:
[![](http://imagizer.imageshack.us/v2/640x480q90/540/cLGFV6.png)]()

###**UIViewController** In your main class add :###
```swift
class MyClassViewController: UIViewController {
        
        /* GameCenter Swift */
        var gameCenter: GameCenter! 
        
        override func viewDidLoad() {
                super.viewDidLoad()
                
                /* Add delegate root view controller in GameCenter Swift */
                self.gameCenter = GameCenter(rootViewController: self)
                /* Open Windows Game Center if player not login in Game Center */
                self.gameCenter.loginToGameCenter() {
                    (result: Bool) in
                    if result {
                        /* Player is login in Game Center OR Open Windows for login in Game Center */
                    } else {
                        /* Player is not nogin in Game Center */
                    }
                }
        }
}

```

###**Method** for Simple Class Game Center :###

##**Things you can do**##
=====
**Show Game Center Player**
```swift
/**
    Show Game Center Player
    
    Without completion 
*/
self.gameCenter.showGameCenter(completion: nil)

/**
    Show Game Center Player
    
    With completion check Game Center Window is open
*/
self.gameCenter.showGameCenter { (result) -> Void in
    if result {
        /* Game Center Window is open */
    } else {
        /* Game Center Window is not open (Example player not login in Game Center) */
    }
}
```
**Show Game Center Leaderboard passed as string into Function**

Thanks to J0hnniemac author
```swift
/**
    Show Game Center Leaderboard passed as string into function
    
    Without completion
*/
gameCenter.showGameCenterLeaderboard(leaderboardIdentifier: String, completion: nil)

/**
    Show Game Center Leaderboard passed as string into function
    
    With completion check Game Center Window is open
*/
gameCenter.showGameCenterLeaderboard(leaderboardIdentifier: String) { (result) -> Void in
    if result {
        /* Game Center Window is open */
    } else {
        /* Game Center Window is not open (Example player not login in Game Center) */
    }
}
```

**Forcing the player to identify themselves on game center if it did not already**
```swift
/**
    Forcing the player to identify themselves on game center if it did not already
    
    Without Completion
*/
self.gameCenter.loginToGameCenter(completion: nil)

/**
    Forcing the player to identify themselves on game center if it did not already
    
    With Completion for Open Windows Login in Game Center if player is not Login or do nothing if he is already identified
*/
gameCenter.loginToGameCenter() {
    (result: Bool) in
    if result {
        /* Player is Login in Game Center OR Open Windows for login in Game Center */
    } else {
        /* Player is Not Login in Game Center */
    }
}
```
### Reports Scores or Achievements ###

**Add progress to an Achievement**

```swift
/**
    Add progress to an achievement
    
    :param: Add progress to an achievement Double (ex: 10% = 10.00)
    :param: Achievement identifier
*/
gameCenter.addProgressToAnAchievement(progress:Double, achievementIdentifier:String)
```

**Reports a given score to Game Center**
```swift
/**
    Reports a given score to Game Center 
    
    :param: Int Score
    :param: Leaderboard identifier
    
    Without completion
*/
gameCenter.reportScore(score: Int,leaderboardIdentifier: String, completion: nil)

/**
    Reports a given score to Game Center 
    
    :param: Int Score
    :param: Leaderboard identifier
    
    With completion return is your report score work or not
*/
self.gameCenter.reportScore(score: Int, leaderboardIdentifier: String, completion: { (result) -> Void in
        if result {
                /* Result is submit */
        } else {
                /* Is fail */
        }
})
```
### Reset Achievement ###
**Reset one Achievement**
```swift
/**
    Remove One Achievement
    
    :param: Achievement identifier
*/
gameCenter.resetAchievements(achievementIdentifier:String)
```
**Reset All Achievements**
```swift
/**
    Remove All Achievements
*/
gameCenter.resetAllAchievements()
```
### Other methods ###
**If achievement is finished**
```swift
/**
    If achievement is Finish
    
    :param: Achievement identifier
*/
gameCenter.isAchievementFinished(achievementIdentifier:String)
```

### Example Code ###
 ```swift
class MyClassViewController: UIViewController {
        /// GameCenter
        var gameCenter: GameCenter! 
        
        override func viewDidLoad() {
                super.viewDidLoad()
                gameCenter = GameCenter(rootViewController: self)
        }
        /* Open Game Center */
        @IBAction func showGameCenterAction(sender: AnyObject) {
                self.gameCenter.showGameCenter()
        }
        /* My_Achievement_ID Have 100% */
        @IBAction func addProgressAction(sender: AnyObject) {
                self.gameCenter.addProgressToAnAchievement(100.00,"My_Achievement_ID")
        }
        /* Reset All Achievements */
        @IBAction func addProgressAction(sender: AnyObject) {
                self.gameCenter.resetAllAchievements()
        }
}

```
### Legacy support
For support of iOS 7 & 8+ [Yannick Stephan](https://yannickstephan.com) works hard to have as high feature parity with **Simple Game Center** as possible.

### License
The MIT License (MIT)

Copyright (c) 2014 DaRk-_-D0G S. Yannick

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
