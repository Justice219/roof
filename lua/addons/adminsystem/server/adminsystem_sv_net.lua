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
     if !roof.server.player.auth(ply) then return end
     local ply = nil 
     local id = net.ReadString()
     local rank = net.ReadString()

     for k,v in pairs(player.GetAll()) do
          if v:SteamID64() == id then
               ply = v
               break
          end
     end
     

     if !ply then
        roof.server.errors.severe("Player object not found!")    
     return end

     adminsystem.server.player.changeGroup(ply, rank)
end)
net.Receive("AdminSystem:Net:RemoveRank", function(len, ply)
     adminsystem.server.groups.remove(net.ReadString())
end)
net.Receive("AdminSystem:Net:CreateGroup", function(len, ply)
     local name = net.ReadString()
     local num = net.ReadInt(32)

     adminsystem.server.groups.create(name, num)
end)
net.Receive("AdminSystem:Net:EditGroup", function(len, ply)
     local name = net.ReadString()
     local new = net.ReadString()
     local pri = net.ReadInt(32)

     adminsystem.server.groups.edit(name, new, pri)
end)
net.Receive("AdminSystem:Net:EditPerms", function(len, ply)
     local name = net.ReadString()
     local perm = net.ReadTable()

     for k,v in pairs(perm) do
          print(v)
          if v == true then
               adminsystem.server.groups.addPerm(name, k)
          end
     end
end)
net.Receive("AdminSystem:Net:RunModule", function(len, ply)
     local tbl = net.ReadTable()
     
     adminsystem.server.modules.run(tbl.name, tbl.ply, tbl.args)
end)