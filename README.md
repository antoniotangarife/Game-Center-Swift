Game-Center-Swift
=================

Game-Center-Swift

Begin add attribute :
var gameCenter: GameCenter! 

In UIControler :

override func viewDidLoad() {
        super.viewDidLoad()
        self.gameCenter = GameCenter(uiControlNow: self)
}
