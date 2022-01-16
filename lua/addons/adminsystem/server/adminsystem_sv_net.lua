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