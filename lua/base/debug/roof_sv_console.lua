roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}

-- This file contains all the console commands native to ROOF!
-- If you want to add a new command, add it here, otherwise you can ignore it.
MsgC(Color(255,0,0), "[ROOF]", Color(255,255,255)," Loading console commands...\n")
concommand.Add("roof_addon_clear", function(ply, cmd, args)
    if !roof.server.player.auth(ply) then return end
    roof.server.addons.clear()

    MsgC(Color(255,0,0), "[ROOF CMD]", Color(255,255,255)," Clearing Addons....\n")
end)
concommand.Add("roof_addon_reload", function(ply, cmd, args)
    if !roof.server.player.auth(ply) then return end

    roof.server.addons.clear()
    roof.server.addons.load()

    MsgC(Color(255,0,0), "[ROOF CMD]", Color(255,255,255)," Reloading addons...\n")
end)
concommand.Add("roof_addon_remove", function(ply, cmd, args)
    if !roof.server.player.auth(ply) then return end
    if !args[1] then return end
    roof.server.addons.remove(args[1])
    

    MsgC(Color(255,0,0), "[ROOF CMD]", Color(255,255,255)," Removing Addon: "..args[1].."\n")
end)
concommand.Add("roof_debug_table", function(ply, cmd, args)
    if !roof.server.player.auth(ply) then return end
    PrintTable(roof)
    

    MsgC(Color(255,0,0), "[ROOF CMD]", Color(255,255,255)," Server Debug Table has Printed Above! ^^\n")
end)
concommand.Add("roof_client_load", function(ply, cmd, args)
    if !roof.server.player.auth(ply) then return end
    

    MsgC(Color(255,0,0), "[ROOF CMD]", Color(255,255,255)," Server Debug Table has Printed Above! ^^\n")
end)