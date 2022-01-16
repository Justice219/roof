roof = roof or {}
roof.server = roof.server or {}
roof.server.errors = roof.server.errors or {}
roof.server.player = roof.server.player or {}

adminsystem = adminsystem or {}
adminsystem.server = adminsystem.server or {}
adminsystem.server.net = adminsystem.server.net or {}
adminsystem.server.chat = adminsystem.server.chat or {}
adminsystem.server.data = adminsystem.server.data or {}
adminsystem.server.groups = adminsystem.server.groups or {}
adminsystem.server.data.groups = adminsystem.server.data.groups or {}

concommand.Add("adminsystem_group_create", function(ply, cmd, args)
    if !roof.server.player.auth(ply) then return end
    
    adminsystem.server.groups.create(args[1])
end)
concommand.Add("adminsystem_group_remove", function(ply, cmd, args)
    if !roof.server.player.auth(ply) then return end
    
    adminsystem.server.groups.remove(args[1])
end)
concommand.Add("adminsystem_group_print", function(ply, cmd, args)
    if !roof.server.player.auth(ply) then return end
    
    PrintTable(adminsystem.server.data.groups)
end)
concommand.Add("adminsystem_group_find", function(ply, cmd, args)
    if !roof.server.player.auth(ply) then return end
    
    adminsystem.server.groups.find(args[1])
end)
concommand.Add("adminsystem_groups_reload", function(ply, cmd, args)
    adminsystem.server.groups.clear()
    adminsystem.server.groups.load()
end)