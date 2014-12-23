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
