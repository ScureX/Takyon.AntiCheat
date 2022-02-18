global function AntiCheatInit

struct PlayerData{
    entity player
    float sussyMeter // 0.0 not sus, 1.0 hekcer confirmed
}

void function AntiCheatInit(){
    AddCallback_OnPlayerRespawned(AcOnPlayerSpawned)
}

void function AcOnPlayerSpawned(entity player){
    thread AcWatchPlayer(player)
}

void function AcWatchPlayer(entity player){
    for(;;){
        WaitFrame()
        if(!IsValid(player))
            return

        // logic
        foreach(entity enemy in GetPlayerArray()){
            if( player.GetViewVector().x >= enemy.GetWorldSpaceCenter().x*0.9 && player.GetViewVector().x <= enemy.GetWorldSpaceCenter().x*1.1 &&
                player.GetViewVector().y >= enemy.GetWorldSpaceCenter().y*0.9 && player.GetViewVector().y <= enemy.GetWorldSpaceCenter().y*1.1 ) 
                printl("i see you")

            /*TraceResults result = TraceLine( player.EyePosition(), enemy.EyePosition() + enemy.GetViewVector()*10000, [ player ], TRACE_MASK_SHOT, TRACE_COLLISION_GROUP_NONE )

            // player is looking at enemy
            if( IsValid( result.hitEnt ) && !result.hitEnt.IsWorld() )
            {
                printl("hitEnt: " + result.hitEnt)
                printl("hitGroup:" + result.hitGroup)
            }*/

            //TraceResults trace = TraceLineSimple( player.EyePosition(), enemy.EyePosition(), enemy )
            //if(PlayerCanSeePos(player, GetHeadAttachOrigin( enemy ), true, 1)) // add sumn to origin for center of mass?
                //printl("i see you")
        }
    }
}

/*
PlayerCanSee( entity player, entity ent, bool doTrace, float degrees )
PlayerCanSeePos( entity player, vector pos, bool doTrace, float degrees )

player.GetOrigin()

enemy.FindBodyGroup( "head" ) -> int

TraceLineSimple( player.EyePosition(), enemy.EyePosition(), enemy )

TraceLine( titan.GetOrigin(), titan.GetOrigin() + Vector( 0, 0, -TITAN_EXPLOSION_GROUNDWASH_HEIGHT )
*/