//
//  GameCenter.swift
//
//  Created by Yannick Stephan DaRk-_-D0G on 19/12/2014.
//  YannickStephan.com
//
//	iOS 7.0+
//  Version 2.5
//
//	The MIT License (MIT)
//	Copyright (c) 2014 Tobias Due Munk
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy of
//	this software and associated documentation files (the "Software"), to deal in
//	the Software without restriction, including without limitation the rights to
//	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//	the Software, and to permit persons to whom the Software is furnished to do so,
//	subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//	FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation
import GameKit
/**
    GameCenter iOS
*/
class GameCenter: NSObject, GKGameCenterControllerDelegate {
    
    /// The local player object.
    let gameCenterPlayer = GKLocalPlayer.localPlayer()
    /// player can use GameCenter
    var canUseGameCenter:Bool = false {
        didSet {
            if canUseGameCenter == true {
                /* load prev. achievments form Game Center */
                gameCenterLoadAchievements()
            }
        }}
    /// Achievements of player
    var gameCenterAchievements=[String:GKAchievement]()
    
    var vc: UIViewController
    
    
    /**
    builder
    */
    init(rootViewController viewC: UIViewController) {
        
        self.vc = viewC
        super.init()
        loginToGameCenter()
        
    }
    
    func loginToGameCenter() {
        
        /* login */
        self.gameCenterPlayer.authenticateHandler = {(var gameCenterVC:UIViewController!, var gameCenterError:NSError!) -> Void in
            
            if gameCenterVC != nil {
                self.vc.presentViewController(gameCenterVC, animated: true, completion: { () -> Void in
                    
                })
            } else if self.gameCenterPlayer.authenticated == true {
                //self.self
                self.canUseGameCenter = true
                
            } else  {
                self.canUseGameCenter = false
            }
            
            if gameCenterError != nil {
                println("Game Center error: \(gameCenterError)")
            }
        }
    }
    
    /**
        Dismiss Game Center when player open
        :param: GKGameCenterViewController
    
        Override of GKGameCenterControllerDelegate
    */
    internal func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
        Load achievement in cache
    */
    private func gameCenterLoadAchievements(){
        /* load all prev. achievements for GameCenter for the user to progress can be added */
        var allAchievements=[GKAchievement]()
        ToolKit.log("load archievement")
        GKAchievement.loadAchievementsWithCompletionHandler({ (allAchievements, error:NSError!) -> Void in
            if error != nil{
                println("Game Center: could not load achievements, error: \(error)")
            } else {
                for anAchievement in allAchievements  {
                    if let oneAchievement = anAchievement as? GKAchievement {
                        self.gameCenterAchievements[oneAchievement.identifier] = oneAchievement
                    }
                }
            }
        })
    }
    
    
    /**
        Add progress to an achievement
    
        :param: Progress achievement Double (ex: 10% = 10.00)
        :param: ID Achievement
    */
    func gameCenterAddProgressToAnAchievement(progress:Double,achievementID:String) {
        // only update progress if user opt-in to use Game Center
        if canUseGameCenter == true {
            
            /// lookup if prev progress is logged for this achievement = achievement is already know (and loaded)
            var lookupAchievement:GKAchievement? = gameCenterAchievements[achievementID]
            
            if let achievement = lookupAchievement {
                // found the achievement with the given achievementID, check if it already 100% done
                if achievement.percentComplete != 100 {
                    // set new progress
                    achievement.percentComplete = progress
                    if progress == 100.0  {
                        // show banner only if achievement is fully granted (progress is 100%)
                        achievement.showsCompletionBanner=true
                    }
                    
                    // try to report the progress to the Game Center
                    GKAchievement.reportAchievements([achievement], withCompletionHandler:  {(var error:NSError!) -> Void in
                        if error != nil {
                            println("Couldn't save achievement (\(achievementID)) progress to \(progress) %")
                        }
                    })
                } else {
                    // achievemnt already granted, nothing to do
                    println("DEBUG: Achievement (\(achievementID)) already granted")}
                
            } else {
                // never added  progress for this achievement, create achievement now, recall to add progress
                println("No achievement with ID (\(achievementID)) was found, no progress for this one was recoreded yet. Create achievement now.")
                gameCenterAchievements[achievementID] = GKAchievement(identifier: achievementID)
                // recursive recall this func now that the achievement exist
                gameCenterAddProgressToAnAchievement(progress, achievementID: achievementID)
            }
        }
    }

    /**
        Reports a given score to Game Center
    
        :param: the Score
        :param: leaderboard identifier
    */
    func reportScore(score: Int, leaderboardIdentifier: String) {
        if canUseGameCenter == true {
            var scoreReporter = GKScore(leaderboardIdentifier: leaderboardIdentifier)
            scoreReporter.value = Int64(score)
            var scoreArray: [GKScore] = [scoreReporter]
            GKScore.reportScores(scoreArray, {(error : NSError!) -> Void in
                if error != nil {
                    NSLog(error.localizedDescription)
                }
            })
        }
    }
    /**
        Remove One Achievements
    
        :param: ID Achievement
    */
    func resetAchievements(achievementID:String) {
        if canUseGameCenter == true {
            var lookupAchievement:GKAchievement? = gameCenterAchievements[achievementID]
            
            if let achievement = lookupAchievement {
                GKAchievement.resetAchievementsWithCompletionHandler({ (var error:NSError!) -> Void in
                    if error != nil {
                        ToolKit.log("Couldn't Reset achievement (\(achievementID))")
                    } else {
                        ToolKit.log("Reset achievement (\(achievementID))")
                    }
                })
                
            } else {
                println("No achievement with ID (\(achievementID)) was found, no progress for this one was recoreded yet. Create achievement now.")
                gameCenterAchievements[achievementID] = GKAchievement(identifier: achievementID)
                // recursive recall this func now that the achievement exist
                self.resetAchievements(achievementID)
            }
        }
        
    }
    
    /**
        Show Game Center Player
    */
    func showGameCenter() {
        var gc = GKGameCenterViewController()
        gc.gameCenterDelegate = self
        self.vc.presentViewController(gc, animated: true, completion: nil)
    }
}
