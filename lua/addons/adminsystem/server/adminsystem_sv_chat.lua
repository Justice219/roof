roof = roof or {}
roof.server = roof.server or {}
roof.server.player = roof.server.player or {}

adminsystem = adminsystem or {}
adminsystem.server = adminsystem.server or {}
adminsystem.server.net = adminsystem.server.net or {}
adminsystem.server.chat = adminsystem.server.chat or {}

hook.Add("PlayerSay", "AdminSystemChat", function(ply, text)
    if text == "!admin" then
        if !roof.server.player.auth(ply) then return end
        roof.server.errors.debug("Admin system has been enabled for " .. ply:Nick())
        roof.server.net.loadClientFiles(ply, {
            [1] = "addons/adminsystem/client/adminsystem_ui_menu.lua",
            [2] = "addons/adminsystem/client/adminsystem_cl_net.lua",
        })

        net.Start("AdminSystem:Net:Menus:Main")
        net.Send(ply)
    end
end)