Game-Center-Swift
=================
Game Center iOS Swift Class
By Yannickstephan.com

Begin add attribute :
=================
var gameCenter: GameCenter! 

In UIControler :
=================

override func viewDidLoad() {
        super.viewDidLoad()
        self.gameCenter = GameCenter(uiControlNow: self)
}
After You can :
=================
--> Begin load game Center Achievements
gameCenter.gameCenterLoadAchievements()

--> Add Progress ToAn Achievement
gameCenterAddProgressToAnAchievement(progress:Double,achievementID:String)

--> Reset one Achievements
resetAchievements(achievementID:String)
