#import "GKLocalPlayerHack.h"

@implementation GKLocalPlayerHack

GKLocalPlayer *getLocalPlayer(void)
{
    return [GKLocalPlayer localPlayer];
}

@end
