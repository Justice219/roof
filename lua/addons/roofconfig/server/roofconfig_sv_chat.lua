roof = roof or {}
roof.server = roof.server or {}
roof.server.addons = roof.server.addons or {}

hook.Add("PlayerSay", "RoofConfigCommands", function(ply, txt)
    if txt == "!roof_config" then
        net.Start("RoofConfig:Net:Menus:Main")
        net.Send(ply)
    end
end)