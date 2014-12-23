//
//  GameCenter.swift
//  No Hipster Moustache
//
//  Created by DaRk-_-D0G on 19/12/2014.
//  Copyright (c) 2014 DaRk-_-D0G. All rights reserved.
//	YannickStephan.com
//

import Foundation

/**
	GameCenter iOS 
*/
class GameCenter {

    // Game Center
    let gameCenterPlayer=GKLocalPlayer.localPlayer()
    var canUseGameCenter:Bool = false {
        didSet{if canUseGameCenter == true {// load prev. achievments form Game Center
            gameCenterLoadAchievements()}
        }}
    var gameCenterAchievements=[String:GKAchievement]()
    
    /**
    	builder
    */
    init(uiControlNow : UIViewController) {
        
        
        // Do any additional setup after loading the view.
        self.gameCenterPlayer.authenticateHandler={(var gameCenterVC:UIViewController!, var gameCenterError:NSError!) -> Void in
            
            if gameCenterVC != nil {
                //showAuthenticationDialogWhenReasonable: is an example method name. Create your own method that displays an authentication view when appropriate for your app.
                //showAuthenticationDialogWhenReasonable(gameCenterVC!)
                uiControlNow.presentViewController(gameCenterVC, animated: true, completion: { () -> Void in
                    // no idea
                })
            }
            else if self.self.gameCenterPlayer.authenticated == true {
                self.self.canUseGameCenter = true
            } else  {
                self.canUseGameCenter = false
            }
            
            if gameCenterError != nil
            { println("Game Center error: \(gameCenterError)")}
        }
        
        
    }
    

    /**
    	Load prev achievement granted to the player
    */
    func gameCenterLoadAchievements(){
        // load all prev. achievements for GameCenter for the user to progress can be added
        var allAchievements=[GKAchievement]()
        
        GKAchievement.loadAchievementsWithCompletionHandler({ (allAchievements, error:NSError!) -> Void in
            if error != nil{
                println("Game Center: could not load achievements, error: \(error)")
            } else {
                for anAchievement in allAchievements  {
                    if let oneAchievement = anAchievement as? GKAchievement {
                        self.gameCenterAchievements[oneAchievement.identifier]=oneAchievement}
                }
            }
        })
    }
    
    
    /**
    	Add progress to an achievement

    	:param: Progress achievement Double
    	:param: ID Achievement
    */
    func gameCenterAddProgressToAnAchievement(progress:Double,achievementID:String) {
        if canUseGameCenter == true { // only update progress if user opt-in to use Game Center
            // lookup if prev progress is logged for this achievement = achievement is already know (and loaded) form Game Center for this user
            var lookupAchievement:GKAchievement? = gameCenterAchievements[achievementID]
            
            if let achievement = lookupAchievement {
                // found the achievement with the given achievementID, check if it already 100% done
                if achievement.percentComplete != 100 {
                    // set new progress
                    achievement.percentComplete = progress
                    if progress == 100.0  {achievement.showsCompletionBanner=true}  // show banner only if achievement is fully granted (progress is 100%)
                    
                    // try to report the progress to the Game Center
                    GKAchievement.reportAchievements([achievement], withCompletionHandler:  {(var error:NSError!) -> Void in
                        if error != nil {
                            println("Couldn't save achievement (\(achievementID)) progress to \(progress) %")
                        }
                    })
                }
                else {// achievemnt already granted, nothing to do
                    println("DEBUG: Achievement (\(achievementID)) already granted")}
            } else { // never added  progress for this achievement, create achievement now, recall to add progress
                println("No achievement with ID (\(achievementID)) was found, no progress for this one was recoreded yet. Create achievement now.")
                gameCenterAchievements[achievementID] = GKAchievement(identifier: achievementID)
                // recursive recall this func now that the achievement exist
                gameCenterAddProgressToAnAchievement(progress, achievementID: achievementID)
            }
        }
    }
    /**
    	Remove One Achievements

    	:param: ID Achievement
    */
    func resetAchievements(achievementID:String) {
        
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
