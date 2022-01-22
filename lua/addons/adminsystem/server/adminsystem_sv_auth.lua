roof = roof or {}
roof.server = roof.server or {}
roof.server.player = roof.server.player or {}

adminsystem = adminsystem or {}
adminsystem.server = adminsystem.server or {}
adminsystem.server.net = adminsystem.server.net or {}
adminsystem.server.chat = adminsystem.server.chat or {}
adminsystem.server.data = adminsystem.server.data or {}
adminsystem.server.auth = adminsystem.server.auth or {}

function adminsystem.server.auth.checkPriv(ply, perm)
    if !adminsystem.enabled then return end
    local plys = {}
    for k,v in pairs(player.GetAll()) do
        local g = adminsystem.server.player.findGroup(v)
        if not g then
            plys[v:SteamID64()] = {
                name = v:Nick(),
                group = "User",
                id = v:SteamID64(),
            }
        continue end

        plys[v:SteamID64()] = {
            name = v:Nick(),
            group = g,
            id = v:SteamID64(),
        }
    end

    if not plys[ply:SteamID64()] then
        return false
    end
    
    local group = adminsystem.server.groups.find(plys[ply:SteamID64()].group)
    if !group then return end

    if group.priority == 0 then
        return true, "ovr"
    end

    if group.permissions[perm] then
        return true
    else
        ply:JLIBSendNotification("Admin System", "You do not have the permission to do that!")
        return false
    end
end
function adminsystem.server.auth.checkPriority(ply, group2)
    if !adminsystem.enabled then return end
    local g = adminsystem.server.player.findGroup(ply)
    local g2 = adminsystem.server.groups.find(group2)
    if not g then return false end
    if not g2 then return false end
    
    local group = adminsystem.server.groups.find(g)
    if !group then return false end
    
    if group.name == g2.name then
        return true
    end

    if group.priority > g2.priority then
        return true
    else
        ply:JLIBSendNotification("Admin System", "You do not have the permission to do that!")
        return false
    end
end