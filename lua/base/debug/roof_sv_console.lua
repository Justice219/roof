roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}
roof.server.errors = roof.server.errors or {}
roof.server.data = roof.server.data or {}
roof.server.data.settings = roof.server.data.settings or {}

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
    

    roof.server.errors.normal("Server debug table has printed above!")
end)
concommand.Add("roof_settings_reload", function(ply, cmd, args)
    if !roof.server.player.auth(ply) then return end

    roof.server.settings.clear()
    roof.server.settings.load()

    roof.server.errors.change("Settings Reloaded!")
end)
concommand.Add("roof_settings_create_internal", function(ply, cmd, args)
    if !roof.server.player.auth(ply) then return end

    roof.server.settings.createInternal(args[1], {
        default = true,
        desc = "test",
        category = "test",
    })
end)
concommand.Add("roof_settings_remove_internal", function(ply, cmd, args)
    if !roof.server.player.auth(ply) then return end

    roof.server.db.removeInternal(args[1])
end)

concommand.Add("roof_settings_print", function(ply, cmd, args)
    if !roof.server.player.auth(ply) then return end

    PrintTable(roof.server.data.settings)
end)
concommand.Add("roof_debug_sql", function()
    if !roof.server.player.auth(ply) then return end
    roof.server.errors.debug(sql.LastError())
    roof.server.errors.debug("SQL Debug has Printed Above!")
end)