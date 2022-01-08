roof = roof or {}
roof.server = roof.server or {}
roof.config = roof.config or {}
roof.server.player = roof.server.player or {}

MsgC(Color(255,0,0), "[ROOF]", Color(255,255,255), " Loading player authentication...\n")
local ranks = roof.config.ranks

function roof.server.player.auth(ply)
    if ranks[ply:GetUserGroup()] then
        return true
    else
        MsgC(Color(255,0,0), "[ROOF AUTH]", Color(255,255,255), " Player ", Color(255,0,0), ply:Nick(), Color(255,255,255), " failed a serverside auth check!\n")
        return false
    end
end