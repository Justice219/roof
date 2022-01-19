roof = roof or {}
roof.server = roof.server or {}
roof.server.player = roof.server.player or {}

adminsystem = adminsystem or {}
adminsystem.server = adminsystem.server or {}
adminsystem.server.net = adminsystem.server.net or {}
adminsystem.server.chat = adminsystem.server.chat or {}
adminsystem.server.data = adminsystem.server.data or {}

hook.Add("PlayerSay", "AdminSystemChat", function(ply, text)
    if text == "!admin" then
        if !roof.server.player.auth(ply) then return end
        roof.server.errors.debug("Admin system has been enabled for " .. ply:Nick())
        roof.server.net.loadClientFiles(ply, {
            [1] = "addons/adminsystem/client/adminsystem_ui_menu.lua",
            [2] = "addons/adminsystem/client/adminsystem_cl_net.lua",
        })

        local plys = {}
        for k,v in pairs(player.GetAll()) do
            local g = adminsystem.server.player.findGroup(v)
            if not g then
                plys[v:SteamID64()] = {
                    name = v:Nick(),
                    group = "user",
                    id = v:SteamID64(),
                }
            continue end

            plys[v:SteamID64()] = {
                name = v:Nick(),
                group = g,
                id = v:SteamID64(),
            }
        end

        adminsystem.server.data.clients = plys

        net.Start("AdminSystem:Net:ClientSync")
        net.WriteTable(adminsystem.server.data.groups)
        net.WriteTable(plys)
        net.WriteTable(adminsystem.server.data.permissions)
        local temp = {}
        for k,v in pairs(adminsystem.server.data.modules) do
            temp[k] = {
                name = v.name,
                nick = v.nick,
                description = v.description,
                usage = v.usage,
                args = v.args,
            }
        end
        net.WriteTable(temp)
        net.Send(ply)

        net.Start("AdminSystem:Net:Menus:Main")
        net.Send(ply)
        
    end
end)