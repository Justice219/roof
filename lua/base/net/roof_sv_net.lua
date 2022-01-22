roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}
roof.server.net = roof.server.net or {}

util.AddNetworkString("Roof:Net:LoadClientFiles")


function roof.server.net.loadClientFiles(ply, tbl)
    for k,v in pairs(tbl) do
        AddCSLuaFile(v)
    end


    if ply then
        net.Start("Roof:Net:LoadClientFiles")
        net.WriteTable(tbl)
        net.Send(ply) 
    else
        net.Start("Roof:Net:LoadClientFiles")
        net.WriteTable(tbl)
        net.Broadcast()
    end
end