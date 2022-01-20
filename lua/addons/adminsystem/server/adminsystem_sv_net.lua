roof = roof or {}
roof.server = roof.server or {}
roof.server.errors = roof.server.errors or {}
roof.server.player = roof.server.player or {}

adminsystem = adminsystem or {}
adminsystem.server = adminsystem.server or {}
adminsystem.server.net = adminsystem.server.net or {}

util.AddNetworkString("AdminSystem:Net:Menus:Main")
util.AddNetworkString("AdminSystem:Net:ClientSync")
util.AddNetworkString("AdminSystem:Net:UpdateRank")
util.AddNetworkString("AdminSystem:Net:RemoveRank")
util.AddNetworkString("AdminSystem:Net:CreateGroup")
util.AddNetworkString("AdminSystem:Net:EditGroup")
util.AddNetworkString("AdminSystem:Net:EditPerms")
util.AddNetworkString("AdminSystem:Net:RunModule")

net.Receive("AdminSystem:Net:UpdateRank", function(len, ply)
     if !adminsystem.server.auth.checkPriv(ply, "adminsystem.player.group.update") then return end

     local ply = nil 
     local id = net.ReadString()
     local rank = net.ReadString()

     for k,v in pairs(player.GetAll()) do
          if v:SteamID64() == id then
               ply = v
               break
          end
     end

     adminsystem.server.auth.checkPriority(ply, adminsystem.server.player.findGroup(ply))
     

     if !ply then
        roof.server.errors.severe("Player object not found!")    
     return end

     adminsystem.server.player.changeGroup(ply, rank)
end)
net.Receive("AdminSystem:Net:RemoveRank", function(len, ply)
     local g = net.ReadString()
     if !adminsystem.server.auth.checkPriv(ply, "adminsystem.groups.remove") then return end
     if !adminsystem.server.auth.checkPriority(ply, g) then return end

     adminsystem.server.groups.remove(g)
end)
net.Receive("AdminSystem:Net:CreateGroup", function(len, ply)
     if !adminsystem.server.auth.checkPriv(ply, "adminsystem.groups.create") then return end

     local name = net.ReadString()
     local num = net.ReadInt(32)

     adminsystem.server.groups.create(name, num)
end)
net.Receive("AdminSystem:Net:EditGroup", function(len, ply)
     local name = net.ReadString()

     if !adminsystem.server.auth.checkPriv(ply, "adminsystem.groups.edit") then return end
     if !adminsystem.server.auth.checkPriority(ply, name) then return end

     local new = net.ReadString()
     local pri = net.ReadInt(32)

     adminsystem.server.groups.edit(name, new, pri)
end)
net.Receive("AdminSystem:Net:EditPerms", function(len, ply)
     local name = net.ReadString()

     if !adminsystem.server.auth.checkPriv(ply, "adminsystem.groups.perms") then return end
     if !adminsystem.server.auth.checkPriority(ply, name) then return end

     local perm = net.ReadTable()

     for k,v in pairs(perm) do
          print(k, v)
          if v == true then
               adminsystem.server.groups.addPerm(name, k)
          else
               adminsystem.server.groups.removePerm(name, k)
          end
     end
end)
net.Receive("AdminSystem:Net:RunModule", function(len, ply)
     local tbl = net.ReadTable()
     if !adminsystem.server.auth.checkPriv(ply, tbl.perm) then
          print("failed check")     
     return end
     
     adminsystem.server.modules.run(tbl.name, tbl.ply, tbl.args)
end)