ClearGameEventCallbacks()

const tYellow = "utaunt_elebound_yellow_parent"
const tPurple = "utaunt_elebound_purple_parent"
local player = null
function banner()
{
    if (!(player.InCond(Constants.ETFCond.TF_COND_OFFENSEBUFF) ||  player.InCond(Constants.ETFCond.TF_COND_DEFENSEBUFF) || player.InCond(Constants.ETFCond.TF_COND_REGENONDAMAGEBUFF)) || player.InCond(Constants.ETFCond.TF_COND_HALLOWEEN_GHOST_MODE) || player == null) //checks if player is null, a ghost or NOT buffed
    {   
        EntFire("particle", "Kill") // kills the effect
    }
}

function OnGameEvent_deploy_buff_banner(params)
{
    local eColor = null // effect color
    player = GetPlayerFromUserID(params.buff_owner)
    if(player != null)
    {
        local pTeam = player.GetTeam()
        if(pTeam == 2 )  //changes the effect color to corresponding team
        {
            eColor = tYellow
        } else {
            eColor = tPurple
        }
        local pOrigin = player.GetOrigin() 

        pOrigin.z -= 15 //(lowers the particle effect) can be changed, i lowered it a bit so it wouldt block players view

        local particle = SpawnEntityFromTable("info_particle_system",
        {
            start_active = 1,
            effect_name = eColor,
            origin = pOrigin,
            targetname = "particle",
        })
        EntFireByHandle(particle, "SetParent", "!activator", 0.0, player, player)
        particle.ValidateScriptScope()
        AddThinkToEnt(particle, "banner")
        
    }
}
__CollectGameEventCallbacks(this)
